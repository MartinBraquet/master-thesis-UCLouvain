/* USER CODE BEGIN Header */
/**
 ******************************************************************************
 * @file           : main.c
 * @brief          : Main program body
 ******************************************************************************
 * @attention
 *
 * <h2><center>&copy; Copyright (c) 2020 STMicroelectronics.
 * All rights reserved.</center></h2>
 *
 * This software component is licensed by ST under BSD 3-Clause license,
 * the "License"; You may not use this file except in compliance with the
 * License. You may obtain a copy of the License at:
 *                        opensource.org/licenses/BSD-3-Clause
 *
 ******************************************************************************
 */
/* USER CODE END Header */

#define ARM_MATH_CM0PLUS

/* Includes ------------------------------------------------------------------*/
#include "main.h"

#include "arm_math.h"
#include "arm_const_structs.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */
/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
ADC_HandleTypeDef hadc;

RTC_HandleTypeDef hrtc;

SPI_HandleTypeDef hspi1;

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
static void MX_GPIO_Init(void);
static void MX_RTC_Init(void);
static void MX_SPI1_Init(void);
static void MX_ADC_Init(void);
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */
void Get_arm_fft(void);
void analyze_sound_temporal(void);
void analyze_sound_temporal_mag(void);
void analyze_sound_spectrogram(void);
void KNN(void);
void MeanFrequency(void);
void print_bird(void);
//static uint32_t GetSector(uint32_t Address);
void store_FLASH();
void read_FLASH();

#define F32
#define RETRIEVE_NB_SONGS_PER_BIRD 0

#define SAMPLE_RATE 30000            // Sample rate of the audio in hertz.
#define SAMPLE_RATE_MAG 30000        // f_s > 30kHz to ensure good processing of frequencies < 8kHz
#define FFT_SIZE 128                    // Size of the FFT.
#define BUNCH_SAMPLE_SIZE 80
#define MAX_INDEX_FREQ FFT_SIZE/2-25
#define DELTA_F SAMPLE_RATE/FFT_SIZE
#define DELTA_F_MAG SAMPLE_RATE_MAG/FFT_SIZE

float samples[FFT_SIZE*2];
float magnitudes[FFT_SIZE];
float mag_spectrogram[MAX_INDEX_FREQ][BUNCH_SAMPLE_SIZE];
float sum_mag_spectrogram[MAX_INDEX_FREQ];
const static arm_cfft_instance_f32 *S;

uint32_t opti_freq;
uint32_t opti_freq_below;
uint32_t opti_freq_table[2*BUNCH_SAMPLE_SIZE];
uint32_t mag_bunch_table[2*BUNCH_SAMPLE_SIZE];
//float32_t opti_freq_amplitude[BUNCH_SAMPLE_SIZE];
uint32_t index_freq[BUNCH_SAMPLE_SIZE];
uint32_t mag_freq[BUNCH_SAMPLE_SIZE];

#define N_BIRDS 4
#define N_SONGS 6
float birds_freq_range[4][6] = {{902, 598, 876, 1250, 990, 603},
		{2788, 2936, 2605, 2018, 2075, 2753},
		{3299, 4317, 4075, 3841, 3719, 4344},
		{5895, 5390, 4646, 5937, 5830, 6266}};
uint32_t temp_freq_range[N_BIRDS][N_SONGS];
float mean_f, temp_delta_freq, sum_mag, min_mag, max_mag;
#define FREQ_MAG_TRESH 300
#define KNN_SIZE 5
uint32_t close_freq_index[KNN_SIZE];
uint32_t KNN_bird_indexes_number[N_BIRDS];
uint32_t bird_index, max_number_songs;
uint8_t no_bird;
float sound_correction[MAX_INDEX_FREQ] = {0, 0, 200, 90, 40, 27, 23, 19, 13, 44, 8, 7, 7, 8, 7, 5, 6, 7, 10, 5, 4, 5, 5, 5, 4, 5, 5, 4, 4, 3, 4, 4, 4, 4, 3, 3, 3, 3, 4};
uint32_t nb_songs_per_bird[N_BIRDS];


uint32_t i, j, k, i_end, j_end, num_sample_bunch, num_freq_table, num_freq_bunch;

uint32_t t_acq, t_getfft, t_runfft, t_magfft, t_bunch,t_fft, t_storage;

float maxValue;            // Max FFT value is stored here
uint32_t maxIndex;         // Index in Output array where max value is

#define FLASH_USER_START_ADDR   ((uint32_t)0x0800A000)   /* Start @ of user Flash area */
uint32_t FirstSector = 0, NbOfSectors = 0;
uint32_t Address = 0, SECTORError = 0;
__IO uint32_t data32 = 0;

extern void initialise_monitor_handles(void);

/* USER CODE END 0 */

/**
 * @brief  The application entry point.
 * @retval int
 */
int main(void)
{
	/* USER CODE BEGIN 1 */
	initialise_monitor_handles();
	/* USER CODE END 1 */

	/* MCU Configuration--------------------------------------------------------*/

	/* Reset of all peripherals, Initializes the Flash interface and the Systick. */
	HAL_Init();

	/* USER CODE BEGIN Init */

	/* USER CODE END Init */

	/* Configure the system clock */
	SystemClock_Config();

	/* USER CODE BEGIN SysInit */

	/* USER CODE END SysInit */

	/* Initialize all configured peripherals */
	MX_GPIO_Init();
	MX_RTC_Init();
	MX_SPI1_Init();
	MX_ADC_Init();
	/* USER CODE BEGIN 2 */

	HAL_ADC_Start(&hadc);

#if RETRIEVE_NB_SONGS_PER_BIRD
	read_FLASH();
#endif

	/* USER CODE END 2 */

	/* Infinite loop */
	/* USER CODE BEGIN WHILE */
	while (1)
	{
		/* USER CODE END WHILE */

		/* USER CODE BEGIN 3 */

		//analyze_sound_temporal();
		//analyze_sound_temporal_mag();
		analyze_sound_spectrogram();

		/* USER CODE END 3 */
	}
}

void analyze_sound_temporal(void)
{
	for (i=0; i<2*FFT_SIZE; i+=2) {
		HAL_ADC_PollForConversion(&hadc, 1000);
		samples[i] = HAL_ADC_GetValue(&hadc);
		samples[i+1] = 0;
		//t = HAL_GetTick();
		for (j=0; j<10; j++);
	}

	//t = HAL_GetTick() - t;
	//HAL_Delay(1000);
	//printf("%d\n", HAL_GetTick());
	//HAL_Delay(1000);

	for (i=0; i<2*FFT_SIZE; i+=2) {
		printf("%1.0f ", samples[i]);
	}
	printf("\n");
}

void analyze_sound_temporal_mag(void)
{
	t_bunch = HAL_GetTick();

	for (num_sample_bunch=0; num_sample_bunch<BUNCH_SAMPLE_SIZE; num_sample_bunch++) {
		t_acq = HAL_GetTick();

		for (i=0; i<2*FFT_SIZE; i+=2) {
			HAL_ADC_PollForConversion(&hadc, 1000);
			samples[i] = HAL_ADC_GetValue(&hadc);
			samples[i+1] = 0;
			//t = HAL_GetTick();
			for (int j=0; j<42; j++); // 6.4ms for 128 samples: 20kHz
		}

		t_acq = HAL_GetTick() - t_acq;

		//printf("%d\n", t_acq);

		//t = HAL_GetTick() - t;
		//HAL_Delay(1000);
		//printf("%d\n", HAL_GetTick());
		//HAL_Delay(1000);

		/*
		for (i=0; i<2*FFT_SIZE; i+=2) {
		  printf("%1.0f ", samples[i]);
		}
		printf("\n");
		 */

		t_getfft = HAL_GetTick();
		Get_arm_fft();
		t_getfft = HAL_GetTick() - t_getfft;

		// Run FFT on sample data.
		t_runfft = HAL_GetTick();
		arm_cfft_f32(S, samples, 0, 1);
		t_runfft = HAL_GetTick() - t_runfft;

		// Calculate magnitude of complex numbers output by the FFT.
		t_magfft = HAL_GetTick();
		arm_cmplx_mag_f32(samples, magnitudes, FFT_SIZE);

		for (i=0; i<4; i++) {
			magnitudes[i] = 0;
		}

		arm_max_f32(magnitudes, FFT_SIZE/2, &maxValue, &maxIndex);

		opti_freq = maxIndex * DELTA_F_MAG;

		index_freq[num_sample_bunch] = opti_freq;
		mag_freq[num_sample_bunch] = magnitudes[maxIndex];

		//arm_max_f32(magnitudes, FFT_SIZE/4, &maxValue, &maxIndex);

		//opti_freq_below = maxIndex * 32000 / 355 * 1024 / FFT_SIZE;

		t_magfft = HAL_GetTick() - t_magfft;

		//printf("Optifreq: %d, maxIndex: %d\n", opti_freq, maxIndex);
		//printf("Optifreq below 20kHz: %d, Optifreq: %d, maxIndex: %d\n", opti_freq_below, opti_freq, maxIndex);

		//printf("%d\n ", HAL_GetTick());
	}

	t_bunch = HAL_GetTick() - t_bunch;

	printf("Time: %d  \n", t_bunch);

	printf("\n");
	for (i=0; i<BUNCH_SAMPLE_SIZE; i++) {
		printf("%d ", index_freq[i]);
	}
	printf("\n");
	for (i=0; i<BUNCH_SAMPLE_SIZE; i++) {
		printf("%d ", mag_freq[i]);
	}
	printf("\n");

}

void analyze_sound_spectrogram(void)
{
	t_bunch = HAL_GetTick();

	num_freq_table = 0;

	for (num_sample_bunch=0; num_sample_bunch<BUNCH_SAMPLE_SIZE; num_sample_bunch++) {

		t_acq = HAL_GetTick();

		for (i=0; i<2*FFT_SIZE; i+=2) {
			HAL_ADC_PollForConversion(&hadc, 1000);
			samples[i] = HAL_ADC_GetValue(&hadc);
			samples[i+1] = 0;
			//t = HAL_GetTick();
			for (int j=0; j<48; j++); // j<90 if SAMPLE_RATE = 20000, j<48 if SAMPLE_RATE = 30000
		}

		t_acq = HAL_GetTick() - t_acq;

		//printf("%d\n", t_acq);

		//t = HAL_GetTick() - t;
		//HAL_Delay(1000);
		//printf("%d\n", t_acq());
		//HAL_Delay(1000);
		/*
		  for (int i=0; i<2*FFT_SIZE; i+=2) {
			  printf("%1.0f ", samples[i]);
		  }
		  printf("\n");
		 */

		t_fft = HAL_GetTick();

		t_getfft = HAL_GetTick();
		Get_arm_fft();
		t_getfft = HAL_GetTick() - t_getfft;

		// Run FFT on sample data.
		t_runfft = HAL_GetTick();
		arm_cfft_f32(S, samples, 0, 1);
		t_runfft = HAL_GetTick() - t_runfft;

		// Calculate magnitude of complex numbers output by the FFT.
		t_magfft = HAL_GetTick();
		arm_cmplx_mag_f32(samples, magnitudes, FFT_SIZE);

		//magnitudes[0] = 0;

		/*
		  arm_max_f32(magnitudes, FFT_SIZE/2, &maxValue, &maxIndex);

		  opti_freq = maxIndex * DELTA_F;

		  arm_max_f32(magnitudes, FFT_SIZE/4, &maxValue, &maxIndex);

		  opti_freq_below = maxIndex * DELTA_F;

		  t_magfft = HAL_GetTick() - t_magfft;
		 */

		//printf("Optifreq below 20kHz: %d, Optifreq: %d, maxIndex: %d\n", opti_freq_below, opti_freq, maxIndex);

		t_fft = HAL_GetTick() - t_fft;

		t_storage = HAL_GetTick();

		/*
		num_freq_bunch = 0;
		for (i=0; i<FFT_SIZE/4; i++) {
			if (magnitudes[i] > 15000) {
				opti_freq_table[num_freq_table] = i;
				mag_bunch_table[num_freq_table++] = magnitudes[i];
				num_freq_bunch++;
			}
		}
		index_freq[num_sample_bunch] = num_freq_bunch;
		 */

		t_storage = HAL_GetTick() - t_storage;

		//opti_freq_table[num_sample_bunch] = opti_freq_below;
		//opti_freq_amplitude[num_sample_bunch] = maxValue;

		// Build spectrogram
		for (i=0; i < MAX_INDEX_FREQ; i++) {
			mag_spectrogram[i][num_sample_bunch] = magnitudes[i];
		}


	}

	t_bunch = HAL_GetTick() - t_bunch;

	//printf("Time: %d     %d      %d     %d\n", t_bunch, t_acq, t_fft, t_storage);

	/*
	printf("opti_freq_table: ");
	for (i=0; i<2*BUNCH_SAMPLE_SIZE; i++) {
		printf("%d ", opti_freq_table[i]);
		opti_freq_table[i] = 0;
	}
	printf("\n");
	for (i=0; i<2*BUNCH_SAMPLE_SIZE; i++) {
		printf("%d ", mag_bunch_table[i]);
		mag_bunch_table[i] = 0;
	}
	printf("\n");
	for (i=0; i<BUNCH_SAMPLE_SIZE; i++) {
		printf("%d ", index_freq[i]);
		index_freq[i] = 0;
	}
	printf("\n");
	 */

	KNN();

	if (!no_bird)
		nb_songs_per_bird[bird_index] += 1;

#if RETRIEVE_NB_SONGS_PER_BIRD
	store_FLASH();
#endif

	//printf("Mean frequency: %1.0f, bird index: %d\n", mean_f, bird_index);
	printf("Mean frequency: %1.0f\n", mean_f);
	printf("Number of songs per bird: %d pigeons, %d blackbirds, %d great tits, %d blue tits\n", nb_songs_per_bird[0], nb_songs_per_bird[1], nb_songs_per_bird[2], nb_songs_per_bird[3]);

	print_bird();

	/*
	  //printf("opti_freq_table amplitude: ");
	  for (i=0; i<BUNCH_SAMPLE_SIZE; i++) {
		  printf("%1.0f ", opti_freq_amplitude[i]);
	  }
	  printf("\n");
	 */

	//printf("%d\n ", HAL_GetTick());
}

void print_bird()
{
	if (no_bird) {
		printf("No bird detected\n");
	} else {
		switch (bird_index)
		{
		case 0:
			printf("A pigeon has been detected\n");
			break;
		case 1:
			printf("A blackbird has been detected\n");
			break;
		case 2:
			printf("A great tit has been detected\n");
			break;
		case 3:
			printf("A blue tit has been detected\n");
			break;
		}
	}
}

void KNN(void)
{
	// Extract the weighted mean frequency from mag_spectrogram
	MeanFrequency();

	// Refill temp_freq_range by birds_freq_range
	for (i=0; i < N_BIRDS; i++) {
		for (j=0; j < N_SONGS; j++) {
			temp_freq_range[i][j] = birds_freq_range[i][j];
		}
	}

	// Find the indexes of the frequencies nearest to mean_f and store in close_freq_index
	for (k=0; k < KNN_SIZE; k++) {
		close_freq_index[k] = 11;
		temp_delta_freq = 1e8;
		for (i=0; i < N_BIRDS; i++) {
			for (j=0; j < N_SONGS; j++) {
				if (temp_freq_range[i][j] - mean_f < temp_delta_freq && temp_freq_range[i][j] - mean_f > -temp_delta_freq) {
					temp_delta_freq = temp_freq_range[i][j] - mean_f;
					if (temp_delta_freq < 0)
						temp_delta_freq = -temp_delta_freq;
					i_end = i;
					j_end = j;
				}
			}
		}
		temp_freq_range[i_end][j_end] = 1e8;
		close_freq_index[k] = i_end;
	}

	/*
	printf("\n");
	for (i=0; i<KNN_SIZE; i++) {
		printf("%d ", close_freq_index[i]);
	}
	printf("\n");
	*/

	// Compute the number of index occurences for each bird, store in
	for (i=0; i < N_BIRDS; i++) {
		KNN_bird_indexes_number[i] = 0;
	}
	for (k=0; k < KNN_SIZE; k++) {
		KNN_bird_indexes_number[close_freq_index[k]] += 1;
	}

	max_number_songs = 0;
	for (i=0; i < N_BIRDS; i++) {
		if (KNN_bird_indexes_number[i] > max_number_songs) {
			bird_index = i;
			max_number_songs = KNN_bird_indexes_number[i];
		}
	}
}

void MeanFrequency(void)
{
	// sum_mag_spectrogram: mean of magnitudes for each frequency over the whole time frame
	for (i=0; i < MAX_INDEX_FREQ; i++) {
		sum_mag_spectrogram[i] = 0;
		for (j=0; j < BUNCH_SAMPLE_SIZE; j++) {
			sum_mag_spectrogram[i] += mag_spectrogram[i][j];
		}
	}

	for (i=0; i < MAX_INDEX_FREQ; i++) {
		sum_mag_spectrogram[i] *= sum_mag_spectrogram[i];
	}


	min_mag = 1e26;
	for (i=1; i < MAX_INDEX_FREQ; i++) {
		if (sum_mag_spectrogram[i] < min_mag)
			min_mag = sum_mag_spectrogram[i];
	}
	for (i=0; i < MAX_INDEX_FREQ; i++) {
		sum_mag_spectrogram[i] -= min_mag;
	}

	for (i=0; i < MAX_INDEX_FREQ; i++) {
		sum_mag_spectrogram[i] -= sound_correction[i]*1e7; // Remove constant background sound
	}

	min_mag = 1e26;
	for (i=10; i < MAX_INDEX_FREQ; i++) {
		if (sum_mag_spectrogram[i] < min_mag)
			min_mag = sum_mag_spectrogram[i];
	}
	for (i=0; i < MAX_INDEX_FREQ; i++) {
		sum_mag_spectrogram[i] -= min_mag;
	}


	// sum_mag: sum of magnitudes for the whole time frame (frequency and time)
	sum_mag = 0;
	for (i=1; i < MAX_INDEX_FREQ; i++) {
		sum_mag += sum_mag_spectrogram[i];
	}


	// mean_f: weighted mean frequency over the whole time frame
	mean_f = 0;
	for (i=2; i < MAX_INDEX_FREQ; i++) {
		mean_f += sum_mag_spectrogram[i] * i * DELTA_F / sum_mag;
		//printf("%1.0f ", sum_mag_spectrogram[i]/1e7);
	}

	// max_mag: max magnitude has to be > threshold
	max_mag = 0;
	for (i=2; i < MAX_INDEX_FREQ; i++) {
		if (sum_mag_spectrogram[i] > max_mag)
			max_mag = sum_mag_spectrogram[i];
	}
	no_bird = 0;
	if (max_mag/1e7 < FREQ_MAG_TRESH) {
		no_bird = 1;
	}
}


void store_FLASH()
{
	/* Unlock the Flash to enable the flash control register access *************/
	if (HAL_FLASH_Unlock() == HAL_ERROR)
		printf("Error in HAL_FLASH_Unlock\n");

	__HAL_FLASH_CLEAR_FLAG(0xFFFF);

	/* Erase the user Flash area
	    (area defined by FLASH_USER_START_ADDR and FLASH_USER_END_ADDR) ***********/

	/* Get the 1st sector to erase */
	//FirstSector = GetSector(FLASH_USER_START_ADDR);
	/* Fill EraseInit structure*/
	//EraseInitStruct.TypeErase     = TYPEERASE_SECTORS;
	//EraseInitStruct.VoltageRange  = VOLTAGE_RANGE_3;
	//EraseInitStruct.Sector        = FirstSector;
	//EraseInitStruct.NbSectors     = N_BIRDS;
	//if (HAL_FLASHEx_Erase(&EraseInitStruct, &SECTORError) != HAL_OK)
	//{
		/*
	      Error occurred while sector erase.
	      User can add here some code to deal with this error.
	      SECTORError will contain the faulty sector and then to know the code error on this sector,
	      user can call function 'HAL_FLASH_GetError()'
		 */
	//	printf("Error in FLASH program init\n");
	//}

	/* Note: If an erase operation in Flash memory also concerns data in the data or instruction cache,
	     you have to make sure that these data are rewritten before they are accessed during code
	     execution. If this cannot be done safely, it is recommended to flush the caches by setting the
	     DCRST and ICRST bits in the FLASH_CR register. */
	//__HAL_FLASH_DATA_CACHE_DISABLE();
	//__HAL_FLASH_INSTRUCTION_CACHE_DISABLE();

	//__HAL_FLASH_DATA_CACHE_RESET();
	//__HAL_FLASH_INSTRUCTION_CACHE_RESET();

	//__HAL_FLASH_INSTRUCTION_CACHE_ENABLE();
	//__HAL_FLASH_DATA_CACHE_ENABLE();

	/* Program the user Flash area word by word
	    (area defined by FLASH_USER_START_ADDR and FLASH_USER_END_ADDR) ***********/

	Address = FLASH_USER_START_ADDR;

	for (i=0; i < N_BIRDS; i++)
	{
		//nb_songs_per_bird[i] = 3;
		if (HAL_FLASH_Program(FLASH_TYPEPROGRAM_WORD, Address, 0) == HAL_OK)
		{
			Address = Address + 4;
		}
		else
		{
			/* Error occurred while writing data in Flash memory.
	         User can add here some code to deal with this error */
			uint32_t e = HAL_FLASH_GetError();
			printf("Error in FLASH program\n");
		}
	}

	/* Lock the Flash to disable the flash control register access (recommended
	     to protect the FLASH memory against possible unwanted operation) *********/
	if (HAL_FLASH_Lock() == HAL_ERROR)
		printf("Error in HAL_FLASH_Lock\n");

}

void read_FLASH()
{
	Address = FLASH_USER_START_ADDR;

	for (i=0; i < N_BIRDS; i++)
	{
		data32 = *(__IO uint32_t *)Address;
		Address = Address + 4;
		nb_songs_per_bird[i] = data32;
	}
}

/**
 * @brief System Clock Configuration
 * @retval None
 */
void SystemClock_Config(void)
{
	RCC_OscInitTypeDef RCC_OscInitStruct = {0};
	RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};
	RCC_PeriphCLKInitTypeDef PeriphClkInit = {0};

	/** Configure the main internal regulator output voltage
	 */
	__HAL_PWR_VOLTAGESCALING_CONFIG(PWR_REGULATOR_VOLTAGE_SCALE1);
	/** Initializes the CPU, AHB and APB busses clocks
	 */
	RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSI|RCC_OSCILLATORTYPE_LSI;
	RCC_OscInitStruct.HSIState = RCC_HSI_ON;
	RCC_OscInitStruct.HSICalibrationValue = RCC_HSICALIBRATION_DEFAULT;
	RCC_OscInitStruct.LSIState = RCC_LSI_ON;
	RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
	RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSI;
	RCC_OscInitStruct.PLL.PLLMUL = RCC_PLLMUL_6;
	RCC_OscInitStruct.PLL.PLLDIV = RCC_PLLDIV_3;
	if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
	{
		Error_Handler();
	}
	/** Initializes the CPU, AHB and APB busses clocks
	 */
	RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
			|RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
	RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
	RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
	RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV1;
	RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;

	if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_1) != HAL_OK)
	{
		Error_Handler();
	}
	PeriphClkInit.PeriphClockSelection = RCC_PERIPHCLK_RTC;
	PeriphClkInit.RTCClockSelection = RCC_RTCCLKSOURCE_LSI;
	if (HAL_RCCEx_PeriphCLKConfig(&PeriphClkInit) != HAL_OK)
	{
		Error_Handler();
	}
}

/**
 * @brief ADC Initialization Function
 * @param None
 * @retval None
 */
static void MX_ADC_Init(void)
{

	/* USER CODE BEGIN ADC_Init 0 */

	/* USER CODE END ADC_Init 0 */

	ADC_ChannelConfTypeDef sConfig = {0};

	/* USER CODE BEGIN ADC_Init 1 */

	/* USER CODE END ADC_Init 1 */
	/** Configure the global features of the ADC (Clock, Resolution, Data Alignment and number of conversion)
	 */
	hadc.Instance = ADC1;
	hadc.Init.OversamplingMode = DISABLE;
	hadc.Init.ClockPrescaler = ADC_CLOCK_SYNC_PCLK_DIV4;
	hadc.Init.Resolution = ADC_RESOLUTION_12B;
	hadc.Init.SamplingTime = ADC_SAMPLETIME_7CYCLES_5;
	hadc.Init.ScanConvMode = ADC_SCAN_DIRECTION_FORWARD;
	hadc.Init.DataAlign = ADC_DATAALIGN_RIGHT;
	hadc.Init.ContinuousConvMode = ENABLE;
	hadc.Init.DiscontinuousConvMode = DISABLE;
	hadc.Init.ExternalTrigConvEdge = ADC_EXTERNALTRIGCONVEDGE_NONE;
	hadc.Init.ExternalTrigConv = ADC_SOFTWARE_START;
	hadc.Init.DMAContinuousRequests = DISABLE;
	hadc.Init.EOCSelection = ADC_EOC_SINGLE_CONV;
	hadc.Init.Overrun = ADC_OVR_DATA_PRESERVED;
	hadc.Init.LowPowerAutoWait = DISABLE;
	hadc.Init.LowPowerFrequencyMode = DISABLE;
	hadc.Init.LowPowerAutoPowerOff = DISABLE;
	if (HAL_ADC_Init(&hadc) != HAL_OK)
	{
		Error_Handler();
	}
	/** Configure for the selected ADC regular channel to be converted.
	 */
	sConfig.Channel = ADC_CHANNEL_2;
	sConfig.Rank = ADC_RANK_CHANNEL_NUMBER;
	if (HAL_ADC_ConfigChannel(&hadc, &sConfig) != HAL_OK)
	{
		Error_Handler();
	}
	/** Configure for the selected ADC regular channel to be converted.
	 *//*
  sConfig.Channel = ADC_CHANNEL_3;
  if (HAL_ADC_ConfigChannel(&hadc, &sConfig) != HAL_OK)
  {
    Error_Handler();
  }*/
	/* USER CODE BEGIN ADC_Init 2 */

	/* USER CODE END ADC_Init 2 */

}

/**
 * @brief RTC Initialization Function
 * @param None
 * @retval None
 */
static void MX_RTC_Init(void)
{

	/* USER CODE BEGIN RTC_Init 0 */

	/* USER CODE END RTC_Init 0 */

	RTC_TimeTypeDef sTime = {0};
	RTC_DateTypeDef sDate = {0};
	RTC_AlarmTypeDef sAlarm = {0};

	/* USER CODE BEGIN RTC_Init 1 */

	/* USER CODE END RTC_Init 1 */
	/** Initialize RTC Only
	 */
	hrtc.Instance = RTC;
	hrtc.Init.HourFormat = RTC_HOURFORMAT_24;
	hrtc.Init.AsynchPrediv = 31;
	hrtc.Init.SynchPrediv = 1023;
	hrtc.Init.OutPut = RTC_OUTPUT_DISABLE;
	hrtc.Init.OutPutRemap = RTC_OUTPUT_REMAP_NONE;
	hrtc.Init.OutPutPolarity = RTC_OUTPUT_POLARITY_HIGH;
	hrtc.Init.OutPutType = RTC_OUTPUT_TYPE_OPENDRAIN;
	if (HAL_RTC_Init(&hrtc) != HAL_OK)
	{
		Error_Handler();
	}

	/* USER CODE BEGIN Check_RTC_BKUP */

	/* USER CODE END Check_RTC_BKUP */

	/** Initialize RTC and set the Time and Date
	 */
	sTime.Hours = 0;
	sTime.Minutes = 0;
	sTime.Seconds = 0;
	sTime.DayLightSaving = RTC_DAYLIGHTSAVING_NONE;
	sTime.StoreOperation = RTC_STOREOPERATION_RESET;
	if (HAL_RTC_SetTime(&hrtc, &sTime, RTC_FORMAT_BIN) != HAL_OK)
	{
		Error_Handler();
	}
	sDate.WeekDay = RTC_WEEKDAY_MONDAY;
	sDate.Month = RTC_MONTH_JANUARY;
	sDate.Date = 1;
	sDate.Year = 0;

	if (HAL_RTC_SetDate(&hrtc, &sDate, RTC_FORMAT_BIN) != HAL_OK)
	{
		Error_Handler();
	}
	/** Enable the Alarm A
	 */
	sAlarm.AlarmTime.Hours = 0;
	sAlarm.AlarmTime.Minutes = 0;
	sAlarm.AlarmTime.Seconds = 0;
	sAlarm.AlarmTime.SubSeconds = 0;
	sAlarm.AlarmTime.DayLightSaving = RTC_DAYLIGHTSAVING_NONE;
	sAlarm.AlarmTime.StoreOperation = RTC_STOREOPERATION_RESET;
	sAlarm.AlarmMask = RTC_ALARMMASK_NONE;
	sAlarm.AlarmSubSecondMask = RTC_ALARMSUBSECONDMASK_NONE;
	sAlarm.AlarmDateWeekDaySel = RTC_ALARMDATEWEEKDAYSEL_DATE;
	sAlarm.AlarmDateWeekDay = 1;
	sAlarm.Alarm = RTC_ALARM_A;
	if (HAL_RTC_SetAlarm_IT(&hrtc, &sAlarm, RTC_FORMAT_BIN) != HAL_OK)
	{
		Error_Handler();
	}
	/* USER CODE BEGIN RTC_Init 2 */

	/* USER CODE END RTC_Init 2 */

}

/**
 * @brief SPI1 Initialization Function
 * @param None
 * @retval None
 */
static void MX_SPI1_Init(void)
{

	/* USER CODE BEGIN SPI1_Init 0 */

	/* USER CODE END SPI1_Init 0 */

	/* USER CODE BEGIN SPI1_Init 1 */

	/* USER CODE END SPI1_Init 1 */
	/* SPI1 parameter configuration*/
	hspi1.Instance = SPI1;
	hspi1.Init.Mode = SPI_MODE_MASTER;
	hspi1.Init.Direction = SPI_DIRECTION_2LINES;
	hspi1.Init.DataSize = SPI_DATASIZE_8BIT;
	hspi1.Init.CLKPolarity = SPI_POLARITY_LOW;
	hspi1.Init.CLKPhase = SPI_PHASE_1EDGE;
	hspi1.Init.NSS = SPI_NSS_SOFT;
	hspi1.Init.BaudRatePrescaler = SPI_BAUDRATEPRESCALER_32;
	hspi1.Init.FirstBit = SPI_FIRSTBIT_MSB;
	hspi1.Init.TIMode = SPI_TIMODE_DISABLE;
	hspi1.Init.CRCCalculation = SPI_CRCCALCULATION_DISABLE;
	hspi1.Init.CRCPolynomial = 7;
	if (HAL_SPI_Init(&hspi1) != HAL_OK)
	{
		Error_Handler();
	}
	/* USER CODE BEGIN SPI1_Init 2 */

	/* USER CODE END SPI1_Init 2 */

}

/**
 * @brief GPIO Initialization Function
 * @param None
 * @retval None
 */
static void MX_GPIO_Init(void)
{
	GPIO_InitTypeDef GPIO_InitStruct = {0};

	/* GPIO Ports Clock Enable */
	__HAL_RCC_GPIOA_CLK_ENABLE();
	__HAL_RCC_GPIOB_CLK_ENABLE();
	__HAL_RCC_GPIOC_CLK_ENABLE();
	__HAL_RCC_GPIOH_CLK_ENABLE();

	/*Configure GPIO pin Output Level */
	HAL_GPIO_WritePin(GPIOA, PA15_RESERVED_Pin|PA12_RESERVED_Pin|PA1_RESERVED_Pin, GPIO_PIN_RESET);

	/*Configure GPIO pin Output Level */
	HAL_GPIO_WritePin(GPIOC, PC1_RESERVED_Pin|PC0_RESERVED_Pin|PC2_RESERVED_Pin, GPIO_PIN_RESET);

	/*Configure GPIO pins : PA15_RESERVED_Pin PA12_RESERVED_Pin PA1_RESERVED_Pin */
	GPIO_InitStruct.Pin = PA15_RESERVED_Pin|PA12_RESERVED_Pin|PA1_RESERVED_Pin;
	GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
	GPIO_InitStruct.Pull = GPIO_NOPULL;
	GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
	HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

	/*Configure GPIO pins : PB4_RESERVED_Pin PB1_RESERVED_Pin PB0_RESERVED_Pin */
	GPIO_InitStruct.Pin = PB4_RESERVED_Pin|PB1_RESERVED_Pin|PB0_RESERVED_Pin;
	GPIO_InitStruct.Mode = GPIO_MODE_IT_RISING;
	GPIO_InitStruct.Pull = GPIO_NOPULL;
	HAL_GPIO_Init(GPIOB, &GPIO_InitStruct);

	/*Configure GPIO pin : PC13_RESERVED_Pin */
	GPIO_InitStruct.Pin = PC13_RESERVED_Pin;
	GPIO_InitStruct.Mode = GPIO_MODE_IT_RISING;
	GPIO_InitStruct.Pull = GPIO_NOPULL;
	HAL_GPIO_Init(PC13_RESERVED_GPIO_Port, &GPIO_InitStruct);

	/*Configure GPIO pins : PC1_RESERVED_Pin PC0_RESERVED_Pin PC2_RESERVED_Pin */
	GPIO_InitStruct.Pin = PC1_RESERVED_Pin|PC0_RESERVED_Pin|PC2_RESERVED_Pin;
	GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
	GPIO_InitStruct.Pull = GPIO_NOPULL;
	GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
	HAL_GPIO_Init(GPIOC, &GPIO_InitStruct);

	/* EXTI interrupt init*/
	HAL_NVIC_SetPriority(EXTI0_1_IRQn, 0, 0);
	HAL_NVIC_EnableIRQ(EXTI0_1_IRQn);

	HAL_NVIC_SetPriority(EXTI4_15_IRQn, 0, 0);
	HAL_NVIC_EnableIRQ(EXTI4_15_IRQn);

}

/* USER CODE BEGIN 4 */

/* USER CODE END 4 */

/**
 * @brief  This function is executed in case of error occurrence.
 * @retval None
 */
void Error_Handler(void)
{
	/* USER CODE BEGIN Error_Handler_Debug */
	/* User can add his own implementation to report the HAL error return state */

	/* USER CODE END Error_Handler_Debug */
}

void Get_arm_fft(void)
{
	// Init arm_ccft_32
#if defined (F32)
	switch (FFT_SIZE)
	{
	case 16:
		S = & arm_cfft_sR_f32_len16;
		break;
	case 32:
		S = & arm_cfft_sR_f32_len32;
		break;
	case 64:
		S = & arm_cfft_sR_f32_len64;
		break;
	case 128:
		S = & arm_cfft_sR_f32_len128;
		break;
	case 256:
		S = & arm_cfft_sR_f32_len256;
		break;
	case 512:
		S = & arm_cfft_sR_f32_len512;
		break;
	case 1024:
		S = & arm_cfft_sR_f32_len1024;
		break;
	case 2048:
		S = & arm_cfft_sR_f32_len2048;
		break;
	case 4096:
		S = & arm_cfft_sR_f32_len4096;
		break;
	}
#else
	switch (FFT_SIZE)
	{
	case 16:
		S = & arm_cfft_sR_q31_len16;
		break;
	case 32:
		S = & arm_cfft_sR_q31_len32;
		break;
	case 64:
		S = & arm_cfft_sR_q31_len64;
		break;
	case 128:
		S = & arm_cfft_sR_q31_len128;
		break;
	case 256:
		S = & arm_cfft_sR_q31_len256;
		break;
	case 512:
		S = & arm_cfft_sR_q31_len512;
		break;
	case 1024:
		S = & arm_cfft_sR_q31_len1024;
		break;
	case 2048:
		S = & arm_cfft_sR_q31_len2048;
		break;
	case 4096:
		S = & arm_cfft_sR_q31_len4096;
		break;
	}
#endif
}

#ifdef  USE_FULL_ASSERT
/**
 * @brief  Reports the name of the source file and the source line number
 *         where the assert_param error has occurred.
 * @param  file: pointer to the source file name
 * @param  line: assert_param error line source number
 * @retval None
 */
void assert_failed(uint8_t *file, uint32_t line)
{ 
	/* USER CODE BEGIN 6 */
	/* User can add his own implementation to report the file name and line number,
     tex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
	/* USER CODE END 6 */
}
#endif /* USE_FULL_ASSERT */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
