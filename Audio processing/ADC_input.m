close all;
a = [2214 2425 3315 2287 2494 1409 1610 3360 2420 2619 2838 1629 1843 2048 1097 2705 2924 1815 2025 1219 1182 2063 2959 1287 2897 3114 2022 2245 1180 1390 3158 3369 2333 2549 1429 1635 3344 1999 2597 2815 1625 1850 2745 1717 1929 2912 1421 2813 3029 1842 2066 1404 1197 2949 3162 2099 2312 1289 1371 3142 3355 1330 2206 3296 2473 2687 1526 1755 3098 1534 2705 2925 1755 1965 1336 1090 1943 1381 1115 2864 3077 2005 2224 1220 1345 3114 3330 2259 2467 1431 1628 3408 3088 2564 2781 3208 1625 2742 1669 1893 2688 1254 2687 2907 1808 2015 2221 1228 2827 3043 1928 2152 1148 1333 3095 3306 1367 3134 3342 2190 2409 1359 1557 3332 3002 2562 2775 1628 
]/4096*2.5;

figure;
plot(a);

L = length(a);
Fs = 17e6/200;            % Sampling frequency                    
T = 1/Fs;             % Sampling period 

Y = fft(a);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
figure;
plot(f,P1);
title('Single-Sided Amplitude Spectrum of X(t)');
xlabel('f (Hz)');
ylabel('|P1(f)|');
ylim([0 0.5]);

figure;
plot(abs(Y));

data = [12256 13696 13696 13696 12256 13696 14416 12256 13696 13696 12256 13696 12256 13696 12256 12256 11536 13696 13696 12256 13696 12256 13696 11536 12256 13696 12256 12256 14416 13696 13696 12256 12256 14416 13696 12256 11536 12256 12256 11536 13696 13696 12256 12256 12256 12256 4320 12256 14416 12256 13696 13696 13696 13696 12256 13696 12256 12256 3600 12256 12256 13696 12256 5040 13696 12256 12256 13696 12256 12256 12256 14416 12256 12256 3600 3600 13696 12256 12256 13696 4320 4320 4320 13696 12256 12256 12256 12256 12256 11536 3600 3600 3600 3600 12256 13696 12256 4320 4320 4320 12256 12256 12256 12256 12256 13696 14416 3600 3600 3600 3600 12256 12256 12256 4320 4320 4320 4320 14416 12256 12256 12256 13696 12256 14416 3600 3600 3600 14416 12256 18744 4320 4320 4320 12256 12256 11536 12256 12256 12256 12256 3600 3600 3600 3600 12256 12256 12256 4320 4320 4320 12256 12256 12256 12256 12256 12256 13696 3600 3600 12256 3600 12256 14416 14416 4320 4320 4320 12256 12256 12256 12256 13696 12256 13696 12256 12256 12256 12256 14416 13696 12256 12256 14416 14416 12256 12256 12256 12256 14416 12256 14416 14416 12256 14416 12256 12256 12256 12256 14416 12256 12256 12256 12256 12256 12256 14416 14416 14416 14416 12256 12256 14416 14416 12256 12256 12256 12256 12256 12256 14416 14416 12256 12256 12256 12256 12256 12256 12256 12256 14416 12256 12256 12256 12256 14416 12256 12256 12256 13696 12256 14416 12256 14416 12256 12256 12256 14416 12256 14416 12256 12256 12256 12256 14416 12256 12256 12256 14416 12256 12256 12256 12256 14416 12256 14416 14416 12256 12256 12256 14416 12256 14416 14416 12256 14416 12256 14416 12256 14416 12256 14416 12256 12256 12256 12256 12256 12256 12256 14416 12256 12256 12256 12256 12256 12256 14416 12256 14416 14416 
25467 24722 20182 23882 19044 22222 24088 24394 21234 26196 22593 21303 26983 21052 25263 28417 21371 26468 18452 23149 23473 19841 20427 23493 24051 27724 20372 19961 21401 20065 25056 21940 26698 22333 22010 22874 20244 22322 26274 21605 24819 22465 22528 19686 23203 18432 43333 21502 26578 23481 23240 24176 21373 25605 19640 23693 22354 23055 25659 28156 23521 20700 23020 18066 17237 23279 22442 29238 24091 23779 25349 26243 22919 28690 34685 38659 20046 23034 25324 26753 80237 114838 25087 20847 25641 27391 24645 24779 24416 23037 34514 83610 58215 26350 26980 20337 25416 122435 109756 34102 23222 24673 23252 23738 24400 18856 28990 29370 89357 60951 21587 25555 25033 22518 127465 88263 24730 49370 27689 28119 27971 27433 28752 29151 24600 75174 83885 59621 23483 23496 17449 101542 122807 52953 17926 27115 27949 20424 25682 27385 24337 46038 71335 39478 37201 28605 28853 27485 89189 105686 55367 27476 25303 28581 30559 24256 23328 22256 27059 44772 24530 22103 31935 22616 22375 53000 80820 68155 26656 25699 23610 27081 22464 26036 26691 20683 25123 26303 27497 23075 21294 23880 22431 25649 22856 28174 25608 22023 26006 22745 22919 27880 24162 28119 24577 29273 28487 18995 24929 24346 25965 25300 27167 28577 28055 23584 24065 25013 24257 28675 28389 23431 26299 23230 24472 25382 24178 22380 27191 26679 22121 25739 19791 28926 26833 23978 25565 26525 21369 23303 29413 25871 28240 23749 24927 23600 25436 24749 27854 22782 28241 26379 21116 22258 27348 26686 24425 25362 19968 19618 25091 25408 28550 23324 24828 30697 25686 21676 24192 25190 26723 28314 23198 25436 18389 24530 26022 27638 29967 26048 28409 25610 26957 26788 25767 22764 26856 24287 24079 28460 26824 23061 25837 27981 29545 25836 25696 20610 25360 20127 27242 26231 27654 22074 25321 28908 26212 26692 24967 27007 
];

freq = data(1,:);
ampl = data(2,:);

freq(ampl<30e3) = 0;

figure;
plot(freq,'.');
xlabel('Samples');
ylabel('Frequency');

data_temp_freq = [16 10 11 16 5 7 6 6 5 5 6 6 5 5 6 6 6 5 5 5 6 6 5 5 5 23 16 6 6 16 16 16 22 23 23 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 1 1 1 0 0 0 0 0 0 0 1 1 1 0 0 0 0 1 1 0 0 0 0 0 0 0 0 1 1 1 0 1 0 1 1 1 0 0 0 0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
];

data_temp_freq(1,:) = data_temp_freq(1,:) * 32000 / 355 * 1024 / 128;

temp_freq = zeros(size(data_temp_freq,2),2);
k = 1;
for i=1:size(data_temp_freq,2)
    for j=1:data_temp_freq(2,i)
        temp_freq(k,1) = i;
        temp_freq(k,2) = data_temp_freq(1,k);
        k = k + 1;
    end
end

figure;
plot(temp_freq(:,1),temp_freq(:,2),'.');
xlabel('Time');
ylabel('Frequency');

data_1khz = [2115 2102 2093 2138 2123 2099 2131 2080 2125 2109 2090 2100 2091 2082 2078 2103 2066 2093 2078 2075 2069 2090 2074 2078 2113 2075 2096 2097 2081 2103 2128 2128 2123 2139 2112 2129 2134 2105 2118 2162 2116 2159 2143 2134 2136 2145 2133 2139 2154 2135 2146 2172 2151 2138 2158 2138 2164 2181 2161 2189 2165 2174 2174 2161 2167 2189 2172 2195 2199 2172 2190 2187 2178 2168 2183 2149 2164 2158 2149 2144 2166 2137 2124 2147 2125 2151 2136 2133 2136 2117 2126 2117 2104 2115 2127 2103 2129 2131 2111 2115 2117 2116 2094 2115 2073 2092 2100 2070 2080 2096 2078 2085 2111 2057 2096 2074 2092 2092 2065 2088 2122 2097 2120 2136 2114 2134 2163 2118 2126 2132 2115 2120 2145 2118 2137 2156 2121 2141 2141 2122 2135 2130 2143 2158 2144 2159 2160 2165 2167 2173 2168 2165 2212 2158 2193 2193 2187 2183 2206 2180 2203 2184 2185 2194 2177 2182 2175 2155 2148 2150 2113 2132 2153 2117 2142 2126 2125 2110 2150 2124 2143 2143 2127 2174 2130 2111 2119 2104 2097 2122 2088 2102 2105 2104 2099 2108 2088 2087 2091 2088 2079 2088 2066 2066 2098 2063 2101 2106 2103 2095 2115 2094 2117 2112 2103 2120 2112 2120 2119 2114 2120 2149 2108 2132 2141 2125 2155 2141 2136 2129 2136 2125 2139 2178 2137 2173 2176 2149 2170 2172 2156 2175 2168 2157 2184 2157 2192 2180 2191 2183 2205 2178 2194 2192 2187 2181 2181 2151 2162 2190 2146 2160 2163 2132 2132 2120 2116 2127 2106 2123 2124 2098 2118 2153 2113 2137 2134 2115 2114 2135 2115 2117 2141 2089 2100 2110 2098 2104 2113 2081 2105 2090 2079 2100 2088 2081 2091 2082 2081 2090 2085 2088 2113 2080 2099 2126 2110 2114 2133 2104 2128 2126 2124 2120 2123 2112 2137 2144 2127 2138 2166 2131 2141 2138 2140 2145 2148 2153 2162 2158 2163 2180 2168 2175 2187 2170 2185 2184 2170 2167 2188 2166 2178 2195 2158 2158 2201 2174 2174 2190 2168 2173 2164 2137 2123 2120 2173 2137 2108 2138 2124 2111 2123 2140 2117 2139 2146 2119 2137 2125 2119 2122 2117 2091 2107 2125 2081 2109 2098 2113 2087 2106 2074 2091 2074 2069 2095 2056 2079 2078 2077 2097 2116 2088 2106 2119 2090 2106 2121 2114 2117 2138 2130 2143 2160 2126 2146 2125 2111 2121 2136 2120 2154 2134 2132 2143 2130 2155 2146 2143 2156 2151 2154 2140 2186 2155 2185 2187 2140 2180 2183 2165 2179 2194 2170 2158 2190 2155 2183 2208 2169 2169 2137 2149 2158 2120 2130 2141 2143 2129 2133 2116 2107 2137 2111 2117 2142 2101 2140 2122 2092 2100 2112 2105 2096 2127 2094 2078 2101 2064 2100 2099 2088 2094 2080 2086 2080 2075 2068 2079 2073 2082 2102 2090 2107 2101 2094 2094 2116 2089 2122 2142 2129 2162 2151 2143 2133 2148 2128 2127 2136 2127 2149 2116 2132 2138 2139 2145 2149 2141 2136 2161 2136 2149 2161 2149 2151 2185 2152 2184 2206 2179 2191 2189 2188 2166 2196 2183 2193 2202 2173 2185 2153 2175 2167 2148 2145 2177 2126 2095 2123 2114 2126 2131 2122 2120 2141 2102 2129 2116 2117 2118 2092 2117 2110 2091 2112 2113 2084 2107 2121 2085 2089 2097 2084 2075 2086 2062 2066 2096 2075 2088 2093 2092 2086 2078 2086 2107 2071 2109 2094 2096 2113 2135 2107 2126 2158 2128 2139 2145 2118 2128 2157 2121 2151 2144 2115 2158 2144 2158 2159 2168 2152 2155 2152 2146 2180 2151 2165 2184 2150 2180 2159 2235 2175 2185 2177 2197 2205 2181 2202 2185 2155 2153 2136 2141 2166 2136 2149 2159 2120 2138 2128 2124 2124 2124 2120 2117 2121 2102 2136 2121 2121 2117 2147 2128 2127 2132 2100 2104 2104 2083 2086 2076 2081 2121 2074 2105 2105 2070 2087 2071 2072 2064 2101 2078 2084 2112 2082 2104 2102 2102 2124 2124 2130 2179 2131 2136 2123 2120 2111 2148 2141 2143 2172 2125 2146 2128 2141 2135 2155 2141 2154 2163 2147 2186 2165 2185 2171 2184 2160 2180 2176 2169 2215 2192 2177 2199 2185 2177 2186 2167 2181 2187 2147 2181 2173 2153 2155 2156 2117 2136 2142 2118 2127 2120 2121 2111 2140 2109 2138 2106 2122 2109 2114 2115 2133 2101 2104 2118 2086 2103 2113 2077 2068 2094 2070 2077 2096 2077 2075 2098 2092 2090 2113 2083 2093 2091 2085 2100 2112 2097 2112 2090 2113 2137 2114 2125 2142 2124 2127 2145 2110 2113 2136 2117 2131 2142 2131 2136 2171 2130 2156 2161 2152 2172 2248 2159 2162 2180 2155 2193 2160 2186 2186 2171 2180 2197 2170 2180 2178 2169 2191 2181 2176 2163 2178 2158 2154 2160 2120 2140 2121 2119 2140 2108 2142 2132 2108 2129 2144 2113 2119 2123 2109 2119 2130 2109 2108 2142 2095 2117 2098 2096 2115 2076 2074 2075 2072 2061 2086 2061 2083 2089 2076 2084 2098 2084 2098 2083 2067 2101 2105 2101 2113 2181 2115 2126 2194 2109 2149 2133 2122 2125 2138 2108 2127 2140 2129 2152 2149 2143 2145 2169 2138 2173 2137 2167 2168 2146 2162 2178 2165 2171 2176 2157 2182 2191 2182 2185 2220 2184 2190 2186 2165 2157 2155 2169 2171 2149 2137 2160 2122 2150 2122 2119 2118 2130 2122 2122 2142 2106 2135 2126 2126 2113 2114 2117 2105 2120 2094 2108 2088 2085 2105 2070 2111 2095 2081 2076 2090 2069 2089 2104 2074 2086 2101 2083 2085 2108 2084 2093 2086 2088 2142 2104 2140 2133 2121 2122 2137 2122 2127 2144 2113 2136 2132 2152 2138 2150 2148 2134 2168 2119 2191 2161 2158 2162 2197 2164 2176 2154 2152 2205 2152 2176 2172 2136 2167 2242 2161 2173 2200 2171 2204 2188 2172 2163 2156 2149 2172 2157 2122 2156 2144 2117 2146 2107 2115 2113 2108 2137 2132 2122 2113 2135 2109 2119 2143 2097 2127 2122 2115 2113 2110 2086 2093 2128 2083 2100 2082 2094 2094 2080 2071 2081 2066 2070 2105 2075 2102 2107 2084 2100 2097 2095 2095 2125 2115 2141 2154 2120 2139 2141 2108 2113 2132 2114 2133 2151 2116 2138 2150 2121 2139 2144 2140 2159 2136 2156 2158 2162 2150 2171 2143 2161 2195 2157 2202 2178 2171 2184 2190 2181 2176 2191 2181 2199 2185 2177 2183 2184 2153 2147 2130 2122 2135 2126 2140 2134 2107 2123 2117 2117 2109 2129 2126 2113 2122 2105 2117 2128 2091 2114 2104 2099 2137 2102 2089 2080 2090 2083 2105 2082 2088 2098 2059 2081 2071 2086 2084 2100 2083 2105 2120 2086 2114 2129 2100 2124 2132 2123 2126 2147 2138 2135 2158 2118 2140 2141 2122 2146 2100 2136 2142 2128 2130 2151 2134 2155 2170 2152 2171 2149 2162 2159 2195 2159 2175 2196 2167 2191 2186 2174 2173 2194 2175 2179 2162 2169 2182 2159 2172 2166 2148 2135 2149 2132 2097 2151 2110 2125 2143 2117 2136 2129 2113 2124 2135 2127 2120 2132 2107 2109 2114 2106 2095 2083 2088 2115 2087 2095 2109 2057 2097 2095 2074 2082 2090 2081 2078 2097 2078 2087 2114 2077 2098 2132 2107 2119 2096 2117 2135 2118 2131 2145 2112 2117 2131 2117 2135 2136 2127 2141 2146 2128 2136 2157 2126 2151 2156 2158 2152 2180 2157 2174 2160 2160 2175 2162 2174 2176 2171 2172 2200 2174 2184 2186 2170 2177 2182 2156 2164 2171 2137 2146 2161 2134 2156 2153 2139 2136 2154 2113 2129 2106 2118 2133 2106 2127 2122 2116 2114 2129 2107 2115 2121 2089 2102 2110 2081 2092 2100 2087 2092 2080 2078 2098 2059 2080 2087 2063 2082 2087 2077 2083 2101 2092 2101 2112 2090 2115 2121 2120 2112 2136 2116 2151 2146 2120 2138 2114 2133 2135 2129 2121 2129 2129 2112 2153 2128 2150 2179 2148 2160 2172 2155 2168 2178 2168 2164 2179 2178 2165 2170 2166 2191 2178 2179 2194 2163 2181 2167 2154 2158 2142 2141 2138 2150 2112 2144 2131 2135 2126 2130 2112 2108 2120 2106 2137 2098 2112 2125 2088 2114 2106 2097 2121 2110 2091 2081 2107 2065 2074 2087 2053 2086 2090 2086 2078 2093 2073 2082 2086 2055 2080 2083 2087 2089 2129 2093 2121 2124 2097 2121 2096 2106 2112 2095 2119 2148 2113 2138 2144 2123 2129 2133 2118 2123 2159 2128 2134 2160 2147 2165 2178 2157 2151 2184 2154 2168 2181 2160 2191 2164 2191 2184 2181 2179 2199 2165 2183 2174 2156 2169 2159 2150 2162 2172 2158 2147 2156 2110 2138 2129 2112 2137 2104 2132 2129 2093 2123 2114 2112 2120 2133 2099 2115 2119 2097 2100 2101 2081 2086 2115 2067 2090 2090 2073 2129 2083 2074 2073 2098 2076 2090 2074 2082 2101 2077 2074 2093 2085 2102 2116 2100 2113 2135 2124 2132 2135 2124 2138 2123 2128 2122 2148 2105 2148 2130 2130 2159 2140 2156 2150 2156 2137 2187 2144 2165 2168 2152 2164 2183 2157 2168 2192 2166 2165 2181 2170 2181 2202 2175 2175 2168 2163 2178 2148 2158 2151 2136 2120 2144 2099 2136 2130 2083 2116 2135 2114 2107 2138 2101 2132 2138 2114 2124 2105 2124 2107 2100 2089 2097 2076 2080 2100 2053 2087 2091 2046 2082 2086 2083 2083 2084 2082 2084 2103 2080 2080 2109 2074 2110 2113 2119 2130 2136 2132 2119 2136 2111 2131 2125 2131 2140 2109 2130 2126 2120 2139 2127 2138 2140 2158 2126 2136 2160 2137 2173 2175 2156 2173 2168 2159 2174 2170 2163 2184 2192 2160 2179 2162 2183 2192 2165 2171 2169 2158 2142 2174 2124 2146 2141 2135 2115 2138 2106 2112 2138 2098 2122 2125 2133 2128 2147 2116 2136 2114 2111 2095 2077 2097 2099 2098 2082 2101 2076 2100 2107 2077 2091 2091 2074 2072 2089 2055 2080 2098 2065 2101 2101 2108 2111 2133 2096 2116 2105 2109 2123 2108 2123 2143 2133 2107 2134 2110 2129 2136 2105 2134 2140 2129 2130 2144 2123 2153 2154 2149 2158 2161 2156 2156 2165 2157 2163 2174 2178 2163 2180 2168 2198 2177 2182 2190 2158 2178 2178 2147 2161 2166 2143 2139 2158 2130 2134 2159 2118 2126 2131 2113 2121 2141 2118 2116 2143 2107 2120 2104 2116 2124 2082 2116 2116 2094 2097 2104 2076 2091 2089 2082 2076 2098 2070 2087 2097 2067 2084 2097 2069 2087 2094 2081 2100 2122 2100 2120 2105 2113 2124 2108 2116 2126 2110 2127 2137 2124 2137 2155 2132 2139 2133 2122 2130 2150 2122 2156 2157 2156 2166 2160 2162 2153 2158 2138 2169 2163 2162 2198 2170 2185 2190 2169 2171 2178 2166 2186 2196 2175 2178 2174 2153 2162 2142 2142 2138 2140 2145 2134 2140 2115 2142 2104 2120 2128 2101 2129 2127 2105 2104 2141 2101 2118 2120 2088 2106 2120 2095 2101 2105 2071 2086 2093 2134 2087 2090 2084 2093 2089 2086 2086 2102 2083 2111 2074 2082 2110 2091 2109 2111 2122 2123 2151 2110 2131 2127 2107 2126 2133 2130 2101 2163 2135 2152 2163 2125 2131 2144 2137 2152 2152 2157 2164 2162 2152 2158 2148 2166 2186 2169 2169 2186 2157 2192 2189 2177 2181 2197 2169 2184 2184 2140 2172 2168 2163 2162 2150 2141 2133 2134 2114 2132 2105 2114 2145 2107 2129 2125 2115 2122 2135 2114 2114 2147 2105 2114 2131 2090 2130 2113 2079 2086 2100 2068 2092 2098 2066 2089 2068 2081 2085 2069 2082 2097 2056 2084 2112 2081 2123 2110 2105 2140 2133 2123 2137 2149 2124 2130 2145 2112 2132 2134 2130 2137 2151 2125 2137 2150 2128 2133 2158 2146 2180 2164 2164 2165 2156 2162 2161 2164 2159 2190 2166 2178 2194 2165 2183 2158 2153 2176 2186 2194 2168 2188 2143 2180 2154 2133 2131 2142 
]/4096*2.5;

data_blue_tit = [12976 14416 14416 12976 14416 12976 12976 14416 12976 5768 12976 14416 5040 12976 12976 14416 12256 12976 12976 12256 14416 14416 12976 15136 12976 12976 12976 12976 15136 12976 14416 14416 12976 12976 14416 12256 12976 11536 13696 11536 13696 11536 11536 11536 11536 11536 11536 13696 11536 13696 13696 11536 11536 13696 13696 13696 13696 13696 13696 11536 13696 13696 13696 11536 11536 13696 7208 13696 13696 13696 11536 7208 13696 13696 13696 7208 11536 7208 7208 13696 7208 7208 7208 11536 13696 6488 6488 5768 5040 5768 5768 6488 5768 5768 5768 5040 5040 5040 5040 13696 5040 4320 5040 5040 13696 4320 13696 4320 5040 5040 13696 13696 13696 13696 11536 11536 13696 13696 13696 13696 11536 13696 13696 11536 13696 13696 13696 13696 11536 11536 13696 13696 13696 13696 11536 13696 11536 13696 13696 13696 13696 13696 13696 11536 12256 13696 13696 13696 13696 13696 13696 13696 13696 13696 13696 13696 13696 12256 13696 13696 13696 12256 13696 13696 12256 13696 13696 13696 13696 13696 12256 13696 14416 11536 13696 13696 13696 13696 11536 13696 13696 13696 13696 13696 13696 13696 13696 13696 13696 13696 13696 13696 2160 2160 2160 11536 7208 7208 7208 11536 14416 12256 12256 7208 11536 7208 7208 7208 7208 7208 12256 13696 6488 6488 5040 5040 13696 6488 6488 5040 5768 5040 4320 5040 5040 2160 2160 4320 4320 5040 5040 11536 4320 4320 4320 4320 4320 4320 4320 14416 4320 12256 13696 4320 13696 13696 11536 13696 13696 11536 15136 13696 12256 13696 13696 13696 12256 13696 13696 12256 13696 13696 13696 13696 13696 13696 13696 13696 12256 13696 12256 12256 12256 13696 14416 13696 11536 13696 14416 13696 13696 12256 13696 12256 12256 11536 12256 13696 12256 11536 13696 12256 12256 13696 13696 12256 11536 12256 13696 13696 
20997 21935 18392 19364 21820 22683 18472 24691 26356 60781 24073 30034 30013 21849 23131 22231 20102 19021 26235 27376 18510 25546 25981 23295 24337 18332 27011 26906 25306 22153 28546 23889 25435 24135 25532 16591 25633 27879 25748 25910 25625 27052 29327 26982 26510 27642 29265 26815 22598 25401 28013 28527 26138 22665 25895 26976 25354 28162 30105 27794 21407 27110 26482 25807 27271 24107 29428 27384 28530 25238 27734 28119 24966 27541 29133 28471 27193 62618 39667 28298 35736 78074 38675 28196 26942 108156 112360 101566 62743 59376 38417 128449 123603 107141 36873 45206 69429 54912 46765 25704 83168 28187 39466 44330 29800 104153 27097 35836 51104 59539 28371 27645 20717 27988 24675 24790 29967 26420 29453 29895 25600 27307 23142 27863 28824 28166 27044 27382 25987 24567 28420 23420 21370 24868 25878 27878 24989 30951 21241 27922 21154 25763 24292 27580 23887 20267 25822 23997 26616 26537 23863 22646 25718 26482 25460 23963 24227 24197 26741 25556 27845 21709 24538 18149 31214 22812 21761 26602 23339 24840 19668 22693 25459 25137 25450 27812 25735 27601 22123 27715 27166 15575 25980 24794 24819 23552 21740 23075 22292 24008 26133 25086 29474 40392 57455 21021 25191 73832 42486 24813 21448 27063 18495 43352 21709 68421 30840 26272 74515 52644 20087 26306 123552 74391 59391 64724 22911 84338 119865 95644 33071 82580 91744 49023 116415 53622 57297 44243 40947 104175 34590 25614 40725 34667 77615 46470 24941 102420 24549 24096 87312 22563 20671 34750 28085 19594 20848 29343 26334 24830 17329 25755 22937 26960 27659 24594 24872 22270 25760 21657 23174 27323 25062 24319 19974 28443 28147 21897 24491 22863 22125 25802 28757 20155 21442 25436 23500 19745 20963 24825 20232 22404 21602 29945 25079 28124 18935 28341 17453 19888 28881 22901 26866 27175 23520 27347 20373 25891 25473 22856 
];

data_great_tit = [12256 13696 13696 13696 12256 13696 14416 12256 13696 13696 12256 13696 12256 13696 12256 12256 11536 13696 13696 12256 13696 12256 13696 11536 12256 13696 12256 12256 14416 13696 13696 12256 12256 14416 13696 12256 11536 12256 12256 11536 13696 13696 12256 12256 12256 12256 4320 12256 14416 12256 13696 13696 13696 13696 12256 13696 12256 12256 3600 12256 12256 13696 12256 5040 13696 12256 12256 13696 12256 12256 12256 14416 12256 12256 3600 3600 13696 12256 12256 13696 4320 4320 4320 13696 12256 12256 12256 12256 12256 11536 3600 3600 3600 3600 12256 13696 12256 4320 4320 4320 12256 12256 12256 12256 12256 13696 14416 3600 3600 3600 3600 12256 12256 12256 4320 4320 4320 4320 14416 12256 12256 12256 13696 12256 14416 3600 3600 3600 14416 12256 18744 4320 4320 4320 12256 12256 11536 12256 12256 12256 12256 3600 3600 3600 3600 12256 12256 12256 4320 4320 4320 12256 12256 12256 12256 12256 12256 13696 3600 3600 12256 3600 12256 14416 14416 4320 4320 4320 12256 12256 12256 12256 13696 12256 13696 12256 12256 12256 12256 14416 13696 12256 12256 14416 14416 12256 12256 12256 12256 14416 12256 14416 14416 12256 14416 12256 12256 12256 12256 14416 12256 12256 12256 12256 12256 12256 14416 14416 14416 14416 12256 12256 14416 14416 12256 12256 12256 12256 12256 12256 14416 14416 12256 12256 12256 12256 12256 12256 12256 12256 14416 12256 12256 12256 12256 14416 12256 12256 12256 13696 12256 14416 12256 14416 12256 12256 12256 14416 12256 14416 12256 12256 12256 12256 14416 12256 12256 12256 14416 12256 12256 12256 12256 14416 12256 14416 14416 12256 12256 12256 14416 12256 14416 14416 12256 14416 12256 14416 12256 14416 12256 14416 12256 12256 12256 12256 12256 12256 12256 14416 12256 12256 12256 12256 12256 12256 14416 12256 14416 14416 
25467 24722 20182 23882 19044 22222 24088 24394 21234 26196 22593 21303 26983 21052 25263 28417 21371 26468 18452 23149 23473 19841 20427 23493 24051 27724 20372 19961 21401 20065 25056 21940 26698 22333 22010 22874 20244 22322 26274 21605 24819 22465 22528 19686 23203 18432 43333 21502 26578 23481 23240 24176 21373 25605 19640 23693 22354 23055 25659 28156 23521 20700 23020 18066 17237 23279 22442 29238 24091 23779 25349 26243 22919 28690 34685 38659 20046 23034 25324 26753 80237 114838 25087 20847 25641 27391 24645 24779 24416 23037 34514 83610 58215 26350 26980 20337 25416 122435 109756 34102 23222 24673 23252 23738 24400 18856 28990 29370 89357 60951 21587 25555 25033 22518 127465 88263 24730 49370 27689 28119 27971 27433 28752 29151 24600 75174 83885 59621 23483 23496 17449 101542 122807 52953 17926 27115 27949 20424 25682 27385 24337 46038 71335 39478 37201 28605 28853 27485 89189 105686 55367 27476 25303 28581 30559 24256 23328 22256 27059 44772 24530 22103 31935 22616 22375 53000 80820 68155 26656 25699 23610 27081 22464 26036 26691 20683 25123 26303 27497 23075 21294 23880 22431 25649 22856 28174 25608 22023 26006 22745 22919 27880 24162 28119 24577 29273 28487 18995 24929 24346 25965 25300 27167 28577 28055 23584 24065 25013 24257 28675 28389 23431 26299 23230 24472 25382 24178 22380 27191 26679 22121 25739 19791 28926 26833 23978 25565 26525 21369 23303 29413 25871 28240 23749 24927 23600 25436 24749 27854 22782 28241 26379 21116 22258 27348 26686 24425 25362 19968 19618 25091 25408 28550 23324 24828 30697 25686 21676 24192 25190 26723 28314 23198 25436 18389 24530 26022 27638 29967 26048 28409 25610 26957 26788 25767 22764 26856 24287 24079 28460 26824 23061 25837 27981 29545 25836 25696 20610 25360 20127 27242 26231 27654 22074 25321 28908 26212 26692 24967 27007 
];

data_temp_freq_great_tit = [16 10 11 16 5 7 6 6 5 5 6 6 5 5 6 6 6 5 5 5 6 6 5 5 5 23 16 6 6 16 16 16 22 23 23 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 1 1 1 0 0 0 0 0 0 0 1 1 1 0 0 0 0 1 1 0 0 0 0 0 0 0 0 1 1 1 0 1 0 1 1 1 0 0 0 0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
];