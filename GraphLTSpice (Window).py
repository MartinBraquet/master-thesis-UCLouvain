#--------------------------------------------------
# LELEC1101
# Group 41
# G. Permentiers, L. Berthus, L. Lahaye, O. Latteur
#--------------------------------------------------

from tkinter import *
from tkinter import messagebox

from matplotlib import pyplot as plt
from numpy import *

'''
fenetre=Tk()

cadre=Frame(fenetre,width=300,height=200,borderwidth=10)
cadre.pack(fill=BOTH)

intro_Labl=Label(cadre,text="Créer un graph LTSpice:")
intro_Labl.pack(side="top")

link_Texte=StringVar()
link_Txt=Entry(cadre,textvariable=link_Texte,width=40)
link_Txt.pack()

valid_Button=Button(fenetre,text="Valider")
valid_Button.pack(side="bottom")

fenetre.mainloop()'''

def plotting(title, legend, data, axeTitle, xlim=False, ylim=False):
	plt.close()
	plt.figure
	plt.title(title)
	temps = data[:, 0]

	i=1;
	while(i<len(legend)):
		plt.plot(temps,data[:,i], label=legend[i])
		plt.legend();
		i+=1;

	if (xlim != False):
		plt.xlim(float(xlim[0]),float(xlim[1]))
	if (ylim != False):
		plt.ylim(float(ylim[0]),float(ylim[1]))
	plt.xlabel(axeTitle[0])
	plt.ylabel(axeTitle[1])
	plt.show()

def data(link):
	fichier = open(link,'r');
	line = fichier.readline();

	# Compte le nombre de donnees
	cLine = 0;
	while (line != ""):
		cLine += 1;
		line = fichier.readline();


	# Reouverture du flux d'entree
	fichier = open(link,'r');
	line = fichier.readline()
	titleC = line.split("\t");
	nbrElement = len(titleC);

	line = fichier.readline();
	donnees = zeros((cLine-1,nbrElement));

	# Debut des nombres
	i = 0;
	while (i < cLine):
		s = line.split("\t")
		s = array(s)
		if (len(s) != nbrElement):
			break;
		donnees[i] = s;

		line = fichier.readline()
		i += 1;
	fichier.close();

	return titleC,donnees

class FormatException(Exception):
	def __init__(self, message):
		self.message = message

class Interface(Frame):
	Title_Text = 0
	link_Text = 0
	cadre_Signaux = 0
	check_yLimit = 0
	yLim_box = 0
	check_xLimit = 0
	xLim_box = 0

	def __init__(self, fenetre, **kwargs):
		Frame.__init__(self, fenetre, width=1000, height=700, **kwargs)
		self.Title_Main=Label(fenetre, text="Créer un graphe").pack(side=TOP)

		self.cadre = Frame(fenetre, width=1000, height=700, borderwidth=10)
		self.cadre.pack()

		cadre_link = LabelFrame(self.cadre, text="Lien du fichier (sans guillemets)", padx=40, pady=10)
		cadre_link.pack(fill="both",expand="yes")
		self.link_Text = StringVar()
		link_box = Entry(cadre_link,textvariable=self.link_Text,width=50).pack()

		cadre_Title = LabelFrame(self.cadre, text="Titre du graphe : ", padx=40, pady=10)
		cadre_Title.pack(fill="both", expand="yes")
		self.Title_Text = StringVar()
		Title_box = Entry(cadre_Title, textvariable=self.Title_Text, width=50).pack()

		cadre_axe = LabelFrame(self.cadre, text="Nom des axes : ", padx=40, pady=10)
		cadre_axe.pack(fill="both", expand="yes")
		axisLabel = Label(cadre_axe,text="Abscisses :").pack(side=LEFT)
		self.axis_Text = StringVar()
		axe_box = Entry(cadre_axe, textvariable=self.axis_Text, width=20).pack(side=LEFT)
		ordonneeLabel = Label(cadre_axe,text="Ordonnées :").pack(side=LEFT)
		self.ordonnee_Text = StringVar()
		ordonnee_box = Entry(cadre_axe, textvariable=self.ordonnee_Text, width=20).pack(side=LEFT)

		button = Button(self.cadre,text="Charger les signaux",command=self.afficheSignaux).pack(side=BOTTOM)

		cadre_limit = LabelFrame(self.cadre, text="Limite du signal (ex: 0;0.1)", padx=40, pady=10)
		cadre_limit.pack(fill="both", expand="yes")
		self.check_xLimit=IntVar()
		Checkbutton(cadre_limit,text="Abscisses :",variable=self.check_xLimit,command=self.xlim).pack(side=LEFT)
		self.xLim_text = StringVar()
		self.xLim_box = Entry(cadre_limit, textvariable=self.xLim_text, width=7)
		self.xLim_box.config(state=DISABLED)
		self.xLim_box.pack(side=LEFT)
		self.check_yLimit = IntVar()
		Checkbutton(cadre_limit,text="Ordonnées : ",variable=self.check_yLimit,command=self.ylim).pack(side=LEFT)
		self.yLim_text = StringVar()
		self.yLim_box = Entry(cadre_limit, textvariable=self.yLim_text, width=7)
		self.yLim_box.pack(side=LEFT)
		self.yLim_box.config(state=DISABLED)

		Label(self.cadre, text="Actions").pack()
		self.cadre_Signaux = PanedWindow(self.cadre, orient=HORIZONTAL)
		self.cadre_Signaux.pack(fill="both", expand="yes")

		button_Valid = Button(fenetre,text="Valider",command=self.make_Graph).pack()
		c = Frame(fenetre,width=300,height=20,borderwidth=10).pack()

	def make_Graph(self):
		try:
			titleC = ["inconnu"]*(len(self.signaux)+1)

			i=0
			while (i < len(self.signaux)):
				titleC[i+1] = (self.signaux[i]).get()
				i += 1;

			xlim = False; ylim = False;
			if (self.check_xLimit.get() == 1):
				xlim = self.xLim_text.get().split(";")
				if (len(xlim) != 2):
					raise FormatException("Format de la limite est <depart>;<fin>")
			if (self.check_yLimit.get() == 1):
				ylim = self.yLim_text.get().split(";")
				if (len(ylim) != 2):
					raise FormatException("Format de la limite est <depart>;<fin>")
			donnee = data(self.link_Text.get())[1]

			plotting(self.Title_Text.get(), titleC, donnee, [self.axis_Text.get(), self.ordonnee_Text.get()], xlim, ylim)
		except FormatException as err:
			messagebox.showerror("Erreur",err)
		except AttributeError:
			messagebox.showerror("Erreur","Veuillez charger les différents signaux")
		except FileNotFoundError :
			messagebox.showerror("Erreur","Veuillez mettre un fichier valable")
		except Exception as err:
			messagebox.showerror("Erreur",("Erreur inconnue\ndétail:\n",err))

	def afficheSignaux(self):
		self.cadre_Signaux.destroy()
		self.cadre_Signaux = PanedWindow(self.cadre, orient=HORIZONTAL)
		self.cadre_Signaux.pack(fill="both", expand="yes")

		try:
			fichier = open(self.link_Text.get(), 'r');
			line = fichier.readline()
			titleC = line.split("\t");
			if (len(titleC)-1 == 0):
				raise Exception
			self.signaux = (len(titleC)-1)*[1]

			i=1
			while (i < len(titleC)):
				f = Frame(borderwidth=2)
				tv = StringVar()
				tv.set(titleC[i])
				self.signaux[i-1] = tv
				e = Entry(f,textvariable=tv, width=15,borderwidth=2).pack(side=LEFT)
				self.cadre_Signaux.add(f)
				i += 1
			self.cadre_Signaux.pack()
		except :
			messagebox.showerror("Erreur","Encodez un fichier valable")
	def ylim(self):
		if (self.check_yLimit.get() == 1):
			self.yLim_box.config(state=NORMAL)
		else:
			self.yLim_box.config(state=DISABLED)
	def xlim(self):
		if (self.check_xLimit.get() == 1):
			self.xLim_box.config(state=NORMAL)
		else:
			self.xLim_box.config(state=DISABLED)

fenetre = Tk()
fenetre.title("Graphe depuis l'export LTSpice")
fenetre.resizable(width=False,height=False)
interface = Interface(fenetre)
interface.mainloop()
interface.destroy()