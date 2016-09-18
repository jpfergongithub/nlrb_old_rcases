************************************
* Script for creating the old R-case archive. I have not included the
* raw data that this script processes, because the original files are
* quite large. Nonetheless it might be of interest to see how this
* file was created, and for that reason I post this here.
************************************

!unzip nlrb_old_cases.txt.zip
infix using nlrb_old_rcases.dct, using(nlrb_old_cases.txt)

label define yesno 1 "Yes" 0 "No"

* nlrb_id will be the unique identifier, though later we'll drop several
* thousand whose value is "1".
replace nlrb_id = subinstr(nlrb_id,".00","",.)
destring nlrb_id, replace
label variable nlrb_id "Unique identifier: NLRB case #"

destring region, replace

label define r_type 1 "RC" 2 "RD" 3 "RM"
encode r_type, generate(r_type_e) label(r_type) noextend
move r_type_e r_type
drop r_type
rename r_type_e r_type

destring docket, replace

do sic3.do
replace sic = "" if sic == "&"
replace sic = "" if sic == "&&"
replace sic = "72" if sic == "&72"
replace sic = "033" if sic == "O33"
replace sic = "" if sic == "K18"
replace sic = sic+"0" if length(sic) == 2
destring sic, replace
label values sic sic3

replace unit = "Clerical" if unit == "CLERI" | unit == "Cler"
replace unit = "Craft" if unit == "CRAFT"
replace unit = "Departmental" if unit == "DEPT" | unit == "Dept"
replace unit = "Drivers" if unit == "DRIVE" | unit == "DRIVR" | ///
	unit == "Truck"
replace unit = "Guard" if unit == "GUARD"
replace unit = "" if unit == "NULL"
replace unit = "Production" if unit == "P&M"
replace unit = "Professional" if unit == "O&T" | unit == "P&T" | ///
	unit == "PrCl" | unit == "Prof"
replace unit = "Other" if unit == "B" | unit == "OTHER"
label define unit 1 "Clerical" 2 "Craft" 3 "Departmental" 4 "Drivers" ///
	5 "Guard" 6 "Production" 7 "Professional" 8 "Other"
encode unit, generate(unit_e) label(unit) noextend
move unit_e unit
drop unit
rename unit_e unit

replace elect_size = "" if elect_size == "-"
replace elect_size = "" if elect_size == "A"
replace elect_size = "" if elect_size == "B"
replace elect_size = "" if elect_size == "C"
replace elect_size = "" if elect_size == "D"
replace elect_size = "" if elect_size == "E"
replace elect_size = "" if elect_size == "F"
replace elect_size = "" if elect_size == "G"
replace elect_size = "" if elect_size == "H"
replace elect_size = "" if elect_size == "I"
replace elect_size = "" if elect_size == "J"
replace elect_size = "" if elect_size == "M"
replace elect_size = "" if elect_size == "O"
replace elect_size = "" if elect_size == "P"
replace elect_size = "" if elect_size == "R"
replace elect_size = "" if elect_size == "S"
replace elect_size = "" if elect_size == "T"
replace elect_size = "" if elect_size == "W"
replace elect_size = "" if elect_size == "X"
replace elect_size = "" if elect_size == "Z"
destring elect_size, replace

label define elect_type 1 "B" 2 "C" 3 "E" 4 "R" 5 "S"
encode elect_type, generate(elect_type_e) label(elect_type) noextend
move elect_type_e elect_type
drop elect_type
rename elect_type_e elect_type

destring elig_voter, replace

destring fst_votes, replace

do nlrb_union.do
replace fst_union = "" if fst_union == "000}"
replace fst_union = "" if fst_union == "0028"
replace fst_union = "" if fst_union == "0108"
replace fst_union = "" if fst_union == "0123"
replace fst_union = "" if fst_union == "0124"
replace fst_union = "" if fst_union == "0128"
replace fst_union = "" if fst_union == "013}"
replace fst_union = "" if fst_union == "0160"
replace fst_union = "" if fst_union == "0163"
replace fst_union = "" if fst_union == "0200"
replace fst_union = "" if fst_union == "0266"
replace fst_union = "" if fst_union == "0277"
replace fst_union = "" if fst_union == "0284"
replace fst_union = "" if fst_union == "0305"
replace fst_union = "" if fst_union == "0312"
replace fst_union = "" if fst_union == "0330"
replace fst_union = "" if fst_union == "0341"
replace fst_union = "" if fst_union == "0348"
replace fst_union = "" if fst_union == "0353"
replace fst_union = "" if fst_union == "0367"
replace fst_union = "" if fst_union == "0372"
replace fst_union = "" if fst_union == "0420"
replace fst_union = "" if fst_union == "0432"
replace fst_union = "" if fst_union == "0434"
replace fst_union = "" if fst_union == "0442"
replace fst_union = "" if fst_union == "0464"
replace fst_union = "" if fst_union == "0468"
replace fst_union = "" if fst_union == "0496"
replace fst_union = "" if fst_union == "0567"
replace fst_union = "" if fst_union == "0602"
replace fst_union = "" if fst_union == "0615"
replace fst_union = "" if fst_union == "0630"
replace fst_union = "" if fst_union == "0640"
replace fst_union = "" if fst_union == "0647"
replace fst_union = "" if fst_union == "0659"
replace fst_union = "" if fst_union == "0663"
replace fst_union = "" if fst_union == "0671"
replace fst_union = "" if fst_union == "0676"
replace fst_union = "" if fst_union == "0689"
replace fst_union = "" if fst_union == "0744"
replace fst_union = "" if fst_union == "0747"
replace fst_union = "" if fst_union == "0750"
replace fst_union = "" if fst_union == "0765"
replace fst_union = "" if fst_union == "0798"
replace fst_union = "" if fst_union == "0803"
replace fst_union = "" if fst_union == "0804"
replace fst_union = "" if fst_union == "0813"
replace fst_union = "" if fst_union == "0819"
replace fst_union = "" if fst_union == "0824"
replace fst_union = "" if fst_union == "0832"
replace fst_union = "" if fst_union == "0834"
replace fst_union = "" if fst_union == "0838"
replace fst_union = "" if fst_union == "0839"
replace fst_union = "" if fst_union == "0885"
replace fst_union = "" if fst_union == "0905"
replace fst_union = "" if fst_union == "0928"
replace fst_union = "" if fst_union == "0939"
replace fst_union = "" if fst_union == "0943"
replace fst_union = "" if fst_union == "0947"
replace fst_union = "" if fst_union == "0958"
replace fst_union = "" if fst_union == "0960"
replace fst_union = "" if fst_union == "0968"
replace fst_union = "" if fst_union == "1890"
replace fst_union = "" if fst_union == "2890"
replace fst_union = "" if fst_union == "5617"
replace fst_union = "" if fst_union == "5795"
replace fst_union = "" if fst_union == "5962"
replace fst_union = "" if fst_union == "6960"
replace fst_union = "AAA" if fst_union == "AAAA"
replace fst_union = "" if fst_union == "AAUP"
replace fst_union = "UNITE-HERE" if fst_union == "UNITE HERE"
replace fst_union = "SIU" if fst_union == "SIUNA"
replace fst_union = "ABG" if fst_union == "ABGW"
replace fst_union = "" if fst_union == "ACT"
replace fst_union = "" if fst_union == "AFSPA"
replace fst_union = "AGM" if fst_union == "AGMA"
replace fst_union = "" if fst_union == "AIU"
replace fst_union = "" if fst_union == "AMO"
replace fst_union = "" if fst_union == "ATDD"
replace fst_union = "AWU" if fst_union == "AWIU"
replace fst_union = "AWU" if fst_union == "AWU1"
replace fst_union = "" if fst_union == "BSPOG"
replace fst_union = "" if fst_union == "CLPR"
replace fst_union = "" if fst_union == "CNA"
replace fst_union = "" if fst_union == "CSTA"
replace fst_union = "" if fst_union == "CTDU"
replace fst_union = "" if fst_union == "CUTW"
replace fst_union = "" if fst_union == "DSCI"
replace fst_union = "" if fst_union == "EAAI"
replace fst_union = "" if fst_union == "FETEMP"
replace fst_union = "AFT" if fst_union == "FNHP-AFT"
replace fst_union = "" if fst_union == "FSOA"
replace fst_union = "" if fst_union == "FUCO"
replace fst_union = "GMP M" if fst_union == "GMP"
replace fst_union = "" if fst_union == "IAI"
replace fst_union = "ABG" if fst_union == "IBGW"
replace fst_union = "" if fst_union == "IGAI"
replace fst_union = "" if fst_union == "IPA"
replace fst_union = "ISEU" if fst_union == "ISEUNA"
replace fst_union = "" if fst_union == "IUISTHE"
replace fst_union = "" if fst_union == "IUJAT"
replace fst_union = "PAT" if fst_union == "IUPAT"
replace fst_union = "" if fst_union == "IUPW-IND"
replace fst_union = "" if fst_union == "IUSO"
replace fst_union = "" if fst_union == "IWNA"
replace fst_union = "" if fst_union == "IWW"
replace fst_union = "" if fst_union == "JNESO"
replace fst_union = "" if fst_union == "MTTD"
replace fst_union = "" if fst_union == "NAATS"
replace fst_union = "" if fst_union == "NASPSO"
replace fst_union = "" if fst_union == "NATCA"
replace fst_union = "" if fst_union == "NEA"
replace fst_union = "" if fst_union == "NFFE"
replace fst_union = "" if fst_union == "NFLPN"
replace fst_union = "" if fst_union == "NMDU"
replace fst_union = "" if fst_union == "NPWU"
replace fst_union = "" if fst_union == "NSOI"
replace fst_union = "NUHHC" if fst_union == "NUHHCE"
replace fst_union = "" if fst_union == "PPE"
replace fst_union = "" if fst_union == "PRCOYC"
replace fst_union = "" if fst_union == "PRCUI"
replace fst_union = "" if fst_union == "PRTI"
replace fst_union = "" if fst_union == "PRUC"
replace fst_union = "" if fst_union == "PRULEELS"
replace fst_union = "" if fst_union == "RTEA"
replace fst_union = "" if fst_union == "SCEA"
replace fst_union = "" if fst_union == "SLUI"
replace fst_union = "" if fst_union == "SPFPA"
replace fst_union = "" if fst_union == "SPGU"
replace fst_union = "" if fst_union == "TEA"
replace fst_union = "" if fst_union == "UGSOA"
replace fst_union = "" if fst_union == "UITA"
replace fst_union = "UIU" if fst_union == "UIU-IND"
replace fst_union = "UMW" if fst_union == "UMWA"
replace fst_union = "USW" if fst_union == "USWA"
replace fst_union = "UWA" if fst_union == "UWUA"
replace fst_union = "FWISU" if fst_union == "WISU"
encode fst_union, generate(fst_union_e) label(nlrb_union) noextend
move fst_union_e fst_union
drop fst_union
rename fst_union_e fst_union

replace sec_union = "" if sec_union == "0067"
replace sec_union = "" if sec_union == "0123"
replace sec_union = "" if sec_union == "0124"
replace sec_union = "" if sec_union == "0138"
replace sec_union = "" if sec_union == "0200"
replace sec_union = "" if sec_union == "0421"
replace sec_union = "" if sec_union == "0432"
replace sec_union = "" if sec_union == "0457"
replace sec_union = "" if sec_union == "0602"
replace sec_union = "" if sec_union == "0640"
replace sec_union = "" if sec_union == "0663"
replace sec_union = "" if sec_union == "0671"
replace sec_union = "" if sec_union == "0747"
replace sec_union = "" if sec_union == "0760"
replace sec_union = "" if sec_union == "0765"
replace sec_union = "" if sec_union == "0795"
replace sec_union = "" if sec_union == "0803"
replace sec_union = "" if sec_union == "0804"
replace sec_union = "" if sec_union == "0813"
replace sec_union = "" if sec_union == "0862"
replace sec_union = "" if sec_union == "0950"
replace sec_union = "" if sec_union == "1272"
replace sec_union = "" if sec_union == "2050"
replace sec_union = "" if sec_union == "323L"
replace sec_union = "" if sec_union == "5932"
replace sec_union = "" if sec_union == "6772"
replace sec_union = "" if sec_union == "6804"
replace sec_union = "AAA" if sec_union == "ACTORS AND ARTISTES OF AMERICA; ASSOCIATED"
replace sec_union = "AEA" if sec_union == "ACTORS EQUITY ASSOCIATION"
replace sec_union = "AGM" if sec_union == "AGMA"
replace sec_union = "ACW" if sec_union == "AGRIC CANNERY WORKERS"
replace sec_union = "ALD" if sec_union == "AIR LINE DISPATCHERS"
replace sec_union = "ALPA" if sec_union == "AIR LINE PILOTS ASSOCIATION"
replace sec_union = "AIW" if sec_union == "ALLIED INDUSTRIAL WORKERS OF AMERICA; INTERNATIONAL UNION,"
replace sec_union = "AWU" if sec_union == "ALUMINUM WORKERS INTERNATIONAL UNION"
replace sec_union = "ABG" if sec_union == "ALUMINUM, BRICK, AND GLASS WORKERS INTERNATIONAL UNION"
replace sec_union = "HFIA" if sec_union == "ASBESTOS WORKERS; INT'L ASSOCIATION OF HEAT AND FROST INSULATORS AND"
replace sec_union = "ATLC" if sec_union == "ATOMIC TRADES LABOR COUNCIL"
replace sec_union = "AWU" if sec_union == "AWIU"
replace sec_union = "" if sec_union == "Air Transport Employees (ATE)"
replace sec_union = "ATU" if sec_union == "Amalgamated Transit Union, AFL-CIO (ATU)"
replace sec_union = "AFSCME" if sec_union == "American Federation of State, County and Municipal Employees, AFL-CIO (AFSCME)"
replace sec_union = "AFT" if sec_union == "American Federation of Teachers, AFL-CIO (AFT)"
replace sec_union = "ANA" if sec_union == "American Nurses' Association (ANA)"
replace sec_union = "" if sec_union == "Atlantic Independent Union (AIU)"
replace sec_union = "BCW" if sec_union == "BAKERY AND CONFECTIONERY WORKERS INTERNATIONAL UNION OF AMERICA"
replace sec_union = "BCTW" if sec_union == "BAKERY, CONFECTIONERY AND TOBACCO WORKERS INTERNATIONAL UNION"
replace sec_union = "BBAI" if sec_union == "BARBERS, BEAUTICIANS AND ALLIED INDUSTRIES INTERNATIONAL ASSOCIATION"
replace sec_union = "BPBD" if sec_union == "BILL POSTERS, BILLERS AND DISTRIBUTORS OF THE UNITED STATES & CANADA;"
replace sec_union = "IBB" if sec_union == "BOILERMAKERS, IRON SHIP BUILDERS, BLACKSMITHS, FORGERS AND HELPERS;"
replace sec_union = "BSW" if sec_union == "BOOT AND SHOE WORKERS UNION"
replace sec_union = "UBCW" if sec_union == "BRICK AND CLAY WORKERS OF AMERICA; THE UNITED"
replace sec_union = "BAC" if sec_union == "BRICKLAYERS AND ALLIED CRAFTSMEN; INTERNATIONAL UNION OF"
replace sec_union = "BWM" if sec_union == "BROOM AND WHISK MAKERS UNION OF AMERICA; INTERNATIONAL"
replace sec_union = "BCTW" if sec_union == "Bakery, Confectionery & Tobacco Workers International Union, AFL-CIO (BCTWU)"
replace sec_union = "CLGW" if sec_union == "CEMENT, LIME, GYPSUM AND ALLIED WORKERS INTERNATIONAL UNION;  UNITED"
replace sec_union = "ICWU" if sec_union == "CHEMICAL WORKERS UNION; INTERNATIONAL"
replace sec_union = "CMIU" if sec_union == "CIGARMAKERS INTERNATIONAL UNION OF AMERICA"
replace sec_union = "CDHW" if sec_union == "CLEANING DYE HOUSE WORKERS"
replace sec_union = "CIU" if sec_union == "COOPERS INTERNATIONAL UNION OF NORTH AMERICA"
replace sec_union = "" if sec_union == "Chicago Truck Drivers Helpers and Warehouse Workers Union (Ind) (CTDU)"
replace sec_union = "CLA" if sec_union == "Christian Labor Association of the United States of America (CLA)"
replace sec_union = "CWA" if sec_union == "Communications Workers of America, AFL-CIO (CWA)"
replace sec_union = "COIU" if sec_union == "Congress of Independent Unions (CIU)"
replace sec_union = "" if sec_union == "DSCI"
replace sec_union = "FWISU" if sec_union == "FEDERATION OF WESTINGHOUSE INDEPENDENT SALARIED UNIONS"
replace sec_union = "IAFF" if sec_union == "FIRE FIGHTERS; INTERNATIONAL ASSOCIATION OF"
replace sec_union = "AFGW" if sec_union == "GLASS WORKERS UNION; AMERICAN FLINT"
replace sec_union = "GPPAW" if sec_union == "GLASS, POTTERY, PLASTICS AND ALLIED WORKERS INTERNATIONAL UNION"
replace sec_union = "GMP M" if sec_union == "GMP"
replace sec_union = "AFGE" if sec_union == "GOVERNMENT EMPLOYEES; AMERICAN FEDERATION OF"
replace sec_union = "AFGM" if sec_union == "GRAIN MILLERS; AMERICAN FEDERATION OF"
replace sec_union = "GAIU" if sec_union == "GRAPHIC ARTS INTERNATIONAL UNION"
replace sec_union = "GCIU" if sec_union == "Graphic Communications International Union, AFL-CIO (GCIU)"
replace sec_union = "HERE" if sec_union == "Hotel Employees & Restaurant Employees International Union, AFL-CIO (HERE)"
replace sec_union = "IBEW" if sec_union == "INTERNATIONAL BROTHERHOOD OF ELECTRICAL WORKERS"
replace sec_union = "IBFO" if sec_union == "INTERNATIONAL BROTHERHOOD OF FIREMEN AND OILERS"
replace sec_union = "BSOIW" if sec_union == "IRON WORKERS; INTERNATIONAL ASSOCIATION OF BRIDGE, STRUCTURAL"
replace sec_union = "ISEU" if sec_union == "ISEUNA"
replace sec_union = "PAT" if sec_union == "IUPAT"
replace sec_union = "IUPW" if sec_union == "IUPW-IND"
replace sec_union = "BSOIW" if sec_union == "International Association of Bridge, Structural and Ornamental Iron Workers, AFL-CIO (BSOWI)"
replace sec_union = "HFIA" if sec_union == "International Association of Heat and Frost Insulators and Asbestos Workers, AFL-CIO (HFIA)"
replace sec_union = "IAM" if sec_union == "International Association of Machinists and Aerospace Workers, AFL-CIO (IAM)"
replace sec_union = "IBB" if sec_union == "International Brotherhood of Boilermakers, Iron Ship Builders, Blacksmiths, Forgers and Helpers, AFL-CIO"
replace sec_union = "IBEW" if sec_union == "International Brotherhood of Electrical Workers, AFL-CIO (IBEW)"
replace sec_union = "PAT" if sec_union == "International Brotherhood of Painters and Allied Trades of the United States and Canada, AFL-CIO (PAT)"
replace sec_union = "IBT" if sec_union == "International Brotherhood of Teamsters (IBT)"
replace sec_union = "IBT" if sec_union == "International Brotherhood of Teamsters, AFL-CIO (IBT)"
replace sec_union = "IFPTE" if sec_union == "International Federation of Professional and Technical Engineers, AFL-CIO (IFPTE)"
replace sec_union = "GUA" if sec_union == "International Guards Union of America (Independent) (GUA)"
replace sec_union = "" if sec_union == "International Security Officers', Police and Guards' Union (SPGU)"
replace sec_union = "NPW" if sec_union == "International Union of Allied, Novelty and Production Workers, AFL-CIO (NPW)"
replace sec_union = "BAC" if sec_union == "International Union of Bricklayers and Allied Craftworkers, AFL-CIO (BAC)"
replace sec_union = "" if sec_union == "International Union of Industrial, Service, Transport and Health Employees"
replace sec_union = "IUOE" if sec_union == "International Union of Operating Engineers, AFL-CIO (IUOE)"
replace sec_union = "PAT" if sec_union == "International Union of Painters and Allied Trades, AFL-CIO, CLC"
replace sec_union = "" if sec_union == "International Union of Security Officers (IUSO)"
replace sec_union = "" if sec_union == "International Union, Security, Police, and Fire Professionals of America (SPFPA)"
replace sec_union = "UAW" if sec_union == "International Union, United Automobile, Aerospace and Agricultural Implement Workers of America, AFL-CIO (UAW)"
replace sec_union = "JWU" if sec_union == "JEWELRY WORKERS UNION; INTERNATIONAL"
replace sec_union = "LDC" if sec_union == "LAUNDRY AND DRY CLEANING INTERNATIONAL UNION"
replace sec_union = "LIUNA" if sec_union == "Laborers' International Union of North America (LIUNA)"
replace sec_union = "LIUNA" if sec_union == "Laborers' International Union of North America, AFL-CIO (LIUNA)"
replace sec_union = "" if sec_union == "Local Independent Union"
replace sec_union = "MCBW" if sec_union == "MEAT CUTTERS AND BUTCHER WORKMEN OF NORTH AMERICA; AMALGAMATED"
replace sec_union = "" if sec_union == "MTTD"
replace sec_union = "MEBA" if sec_union == "Marine Engineers' Beneficial Association, AFL-CIO (MEBA)"
replace sec_union = "NUHHC" if sec_union == "NUHHCE"
replace sec_union = "" if sec_union == "National Federation of Licensed Practical Nurses, Inc. (LPN)"
replace sec_union = "" if sec_union == "National Industrial Workers Union (NFIU)"
replace sec_union = "NOITU" if sec_union == "National Organization of Industrial Trade Unions (ITI)"
replace sec_union = "" if sec_union == "National Production Workers Union (NPWU)"
replace sec_union = "" if sec_union == "National Staff Organization (NSOI)"
replace sec_union = "OPEIU" if sec_union == "Office and Professional Employees International Union, AFL-CIO (OPEIU)"
replace sec_union = "OPCM" if sec_union == "Operative Plasterers' and Cement Masons' International Association of the United States and Canada, AFL-CIO (OPCM)"
replace sec_union = "PSW" if sec_union == "PEANUT SHELLING WORKERS; UNITED"
replace sec_union = "OPCM" if sec_union == "PLASTERERS AND CEMENT MASONS INTERNATIONAL ASSOCIATION OF THE"
replace sec_union = "PACE" if sec_union == "Paper, Allied-Industrial, Chemical and Energy Workers International Union, AFL-CIO (PACE)"
replace sec_union = "RCIA" if sec_union == "RETAIL CLERKS INTERNATIONAL ASSOCIATION"
replace sec_union = "RWDSU" if sec_union == "Retail, Wholesale and Department Store Union (RWDSU)"
replace sec_union = "RWDSU" if sec_union == "Retail, Wholesale and Department Store Union, AFL-CIO (RWDSU)"
replace sec_union = "SEIU" if sec_union == "SERVICE EMPLOYEES INTERNATIONAL UNION"
replace sec_union = "SIU" if sec_union == "SIUNA"
replace sec_union = "SFAAW" if sec_union == "STOVE, FURNACE AND ALLIED APPLIANCE WORKERS INTERNATIONAL UNION"
replace sec_union = "SIU" if sec_union == "Seafarers International Union of North America, AFL-CIO (SIUNA)"
replace sec_union = "SEIU" if sec_union == "Service Employees International Union (SEIU)"
replace sec_union = "SEIU" if sec_union == "Service Employees International Union, AFL-CIO (SEIU)"
replace sec_union = "SMW" if sec_union == "Sheet Metal Workers International Association, AFL-CIO (SMWIA)"
replace sec_union = "TMTF" if sec_union == "TILE, MARBLE & TERRAZZO FINISHERS & SHOPMEN INTERNATIONAL UNION"
replace sec_union = "TWU" if sec_union == "Transport Workers Union of America, AFL-CIO (TWU)"
replace sec_union = "TCU" if sec_union == "Transportation Communications International Union, AFL-CIO (TCIU)"
replace sec_union = "UIU" if sec_union == "UIU-IND"
replace sec_union = "UMW" if sec_union == "UMWA"
replace sec_union = "UNITE-HERE" if sec_union == "UNITE HERE"
replace sec_union = "UBC" if sec_union == "UNITED BROTHERHOOD OF CARPENTERS AND JOINERS OF AMERICA"
replace sec_union = "UFW" if sec_union == "UNITED FARM WORKERS OF AMERICA"
replace sec_union = "USW" if sec_union == "USWA"
replace sec_union = "UWA" if sec_union == "UWUA"
replace sec_union = "UNITE" if sec_union == "Union of Needletrades, Industrial and Textile Employees, AFL-CIO (UNITE)"
replace sec_union = "UA" if sec_union == "United Association of Journeymen and Apprentices of the Plumbing and Pipe Fitting Industry of the United States and Canada, AFL-CIO (PPF)"
replace sec_union = "" if sec_union == "United Association of Office, Sales and Technical Employees (OSTEI)"
replace sec_union = "UBC" if sec_union == "United Brotherhood of Carpenters and Joiners of America (UBC)"
replace sec_union = "UBC" if sec_union == "United Brotherhood of Carpenters and Joiners of America, AFL-CIO (UBC) (CJA)"
replace sec_union = "UE" if sec_union == "United Electrical, Radio and Machine Workers of America (UE)"
replace sec_union = "UFCW" if sec_union == "United Food and Commercial Workers International Union, AFL-CIO (UFCW)"
replace sec_union = "UFCW" if sec_union == "United Food and Commercial Workers International Union, CLC (UFCW)"
replace sec_union = "" if sec_union == "United Government Security Officers of America (UGSOA)"
replace sec_union = "USW" if sec_union == "United Steel, Paper and Forestry, Rubber, Manufacturing, Energy, Allied Industrial and Service Workers International Union"
replace sec_union = "USW" if sec_union == "United Steelworkers of America, AFL-CIO (USWA)"
replace sec_union = "UTU" if sec_union == "United Transportation Union, AFL-CIO (UTU)"
replace sec_union = "UWA" if sec_union == "Utility Workers Union of America, AFL-CIO (UWUA)"
encode sec_union, generate(sec_union_e) label(nlrb_union) noextend
move sec_union_e sec_union
drop sec_union 
rename sec_union_e sec_union

destring sec_votes, replace

replace thr_union = "" if thr_union == "0265"
replace thr_union = "" if thr_union == "0630"
replace thr_union = "" if thr_union == "0799"
replace thr_union = "" if thr_union == "0804"
replace thr_union = "" if thr_union == "0922"
replace thr_union = "" if thr_union == "323L"
replace thr_union = "AWU" if thr_union == "AWIU"
replace thr_union = "SIU" if thr_union == "SIUNA"
replace thr_union = "UMW" if thr_union == "UMWA"
replace thr_union = "USW" if thr_union == "USWA"
replace thr_union = "UWA" if thr_union == "UWUA"
encode thr_union, generate(thr_union_e) label(nlrb_union) noextend
move thr_union_e thr_union
drop thr_union
rename thr_union_e thr_union

destring thr_votes, replace

destring votes_no, replace

replace challenged = "" if challenged == "--" | challenged == "??"
destring challenged, replace

destring elect_contr, replace

generate objection_filed_date = mofd(dofc(clock(obj_fil_dt,"MDYhms")))
format objection_filed_date %tm
move objection_filed_date obj_fil_dt
drop obj_fil_dt

generate problem = length(obj_party) > 1
replace obj_party = "" if problem == 1
replace obj_party = "" if obj_party == "?"
destring obj_party, replace

foreach var of varlist day_obj_el ruling_obj day_dec_el req_review elect_ctrl ///
	hrngctrl day_el_clo stg_closin meth_disp recordctrl {
	encode `var', generate(`var'_e)
	move `var'_e `var'
	drop `var'
	rename `var'_e `var'
	}
	
encode participt, generate(participant)
move participant participt
drop participt

replace incumb_un = "" if incumb_un == "A" | incumb_un == "AWIU" | ///
	incumb_un == "B" | incumb_un == "I" | incumb_un == "O" | ///
	incumb_un == "P"
replace incumb_un = "" if incumb_un == "."
destring incumb_un, replace

replace t_dt_filed = "Yes" if t_dt_filed == "Y"
replace t_dt_filed = "No" if t_dt_filed == "N"
encode t_dt_filed, generate(t_dt_filed_e) label(yesno) noextend
move t_dt_filed_e t_dt_filed
drop t_dt_filed
rename t_dt_filed_e t_dt_filed

generate filed_date = dofc(clock(dt_filed,"MDYhms"))
format filed_date %td
move filed_date dt_filed
drop dt_filed

replace pet_union = "" if pet_union == "617"
replace pet_union = "" if pet_union == "795"
replace pet_union = "" if pet_union == "890"
replace pet_union = "" if pet_union == "960"
replace pet_union = "" if pet_union == "962"
replace pet_union = "AAA" if pet_union == "AAAA"
replace pet_union = "" if pet_union == "AAUP"
replace pet_union = "ABG" if pet_union == "ABGW"
replace pet_union = "" if pet_union == "ACT"
replace pet_union = "" if pet_union == "AFSPA"
replace pet_union = "AGM" if pet_union == "AGMA"
replace pet_union = "" if pet_union == "AIU"
replace pet_union = "" if pet_union == "AMO"
replace pet_union = "" if pet_union == "ATDD"
replace pet_union = "" if pet_union == "BSPOG"
replace pet_union = "" if pet_union == "CLPR"
replace pet_union = "" if pet_union == "CNA"
replace pet_union = "" if pet_union == "CSTA"
replace pet_union = "" if pet_union == "CTDU"
replace pet_union = "" if pet_union == "CUTW"
replace pet_union = "" if pet_union == "EAAI"
replace pet_union = "" if pet_union == "FETEMP"
replace pet_union = "AFT" if pet_union == "FNHP-AFT"
replace pet_union = "" if pet_union == "FSOA"
replace pet_union = "" if pet_union == "FUCO"
replace pet_union = "GMP M" if pet_union == "GMP"
replace pet_union = "" if pet_union == "IAI"
replace pet_union = "ABG" if pet_union == "IBGW"
replace pet_union = "ICWU" if pet_union == "ICW"
replace pet_union = "" if pet_union == "IGAI"
replace pet_union = "ILGWU" if pet_union == "ILGW"
replace pet_union = "" if pet_union == "IPA"
replace pet_union = "" if pet_union == "IUISTHE"
replace pet_union = "" if pet_union == "IUJAT"
replace pet_union = "PAT" if pet_union == "IUPAT"
replace pet_union = "" if pet_union == "IUPW-IND"
replace pet_union = "" if pet_union == "IUSO"
replace pet_union = "" if pet_union == "IWNA"
replace pet_union = "" if pet_union == "IWW"
replace pet_union = "" if pet_union == "JNESO"
replace pet_union = "" if pet_union == "MTTD"
replace pet_union = "" if pet_union == "NAATS"
replace pet_union = "" if pet_union == "NASPSO"
replace pet_union = "" if pet_union == "NATCA"
replace pet_union = "" if pet_union == "NEA"
replace pet_union = "" if pet_union == "NFFE"
replace pet_union = "" if pet_union == "NFLPN"
replace pet_union = "" if pet_union == "NMDU"
replace pet_union = "" if pet_union == "NPWU"
replace pet_union = "" if pet_union == "NSOI"
replace pet_union = "NUHHC" if pet_union == "NUHHCE"
replace pet_union = "" if pet_union == "PPE"
replace pet_union = "" if pet_union == "PRCOYC"
replace pet_union = "" if pet_union == "PRCUI"
replace pet_union = "" if pet_union == "PRTI"
replace pet_union = "" if pet_union == "PRUC"
replace pet_union = "" if pet_union == "PRULEELS"
replace pet_union = "" if pet_union == "RTEA"
replace pet_union = "" if pet_union == "SCEA"
replace pet_union = "AFSCME" if pet_union == "SCME"
replace pet_union = "SIU" if pet_union == "SIUNA"
replace pet_union = "" if pet_union == "SLUI"
replace pet_union = "" if pet_union == "SPFPA"
replace pet_union = "" if pet_union == "UGSOA"
replace pet_union = "" if pet_union == "UITA"
replace pet_union = "UMW" if pet_union == "UMWA"
replace pet_union = "UNITE-HERE" if pet_union == "UNITE HERE"
replace pet_union = "USW" if pet_union == "USWA"
replace pet_union = "UWA" if pet_union == "UWUA"
replace pet_union = "FWISU" if pet_union == "WISU"
replace pet_union = "AWU" if pet_union == "AWIU"
replace pet_union = "" if pet_union == "SPGU"
encode pet_union, generate(pet_union_e) label(nlrb_union) noextend
move pet_union_e pet_union
drop pet_union
rename pet_union_e pet_union

destring valid_for, replace

destring valid_cast, replace

replace t_dt_elect = "Yes" if t_dt_elect == "Y"
replace t_dt_elect = "No" if t_dt_elect == "N"
encode t_dt_elect, generate(t_dt_elect_e) label(yesno) noextend
move t_dt_elect_e t_dt_elect
drop t_dt_elect
rename t_dt_elect_e t_dt_elect

generate election_date = dofc(clock(dt_elect,"MDYhms"))
format election_date %td
move election_date dt_elect
drop dt_elect

label define wonlost 0 "Lost" 1 "Won"
replace wl = "Lost" if wl == "LOST" | wl == "L"
replace wl = "Won" if wl == "WON" | wl == "W"
encode wl, generate(won) label(wonlost) noextend
move won wl
drop wl

destring recodemth, replace

replace gsacty = "" if gsacty == "," | gsacty == "-89" | gsacty == "-97" | ///
	gsacty == "NE" | gsacty == "PO" | gsacty == "POB" | gsacty == "STE" | ///
	gsacty == "11B"
destring gsacty, replace

replace local = upper(local)
generate localnum = real(local)
generate local_name = local if mi(localnum)
drop local
rename localnum local
move local mailballot
move local_name mailballot
replace local = .a if !mi(local_name)

replace mailballot = "Yes" if mailballot == "Y"
replace mailballot = "No" if mailballot == "N"
encode mailballot, generate(mailballot_e) label(yesno) noextend
move mailballot_e mailballot
drop mailballot
rename mailballot_e mailballot

replace t_dt_closd = "Yes" if t_dt_closd == "Y"
replace t_dt_closd = "No" if t_dt_closd == "N"
encode t_dt_closd, generate(t_dt_closd_e) label(yesno) noextend
move t_dt_closd_e t_dt_closd
drop t_dt_closd
rename t_dt_closd_e t_dt_closed

generate closed_date = dofc(clock(dt_closed,"MDYhms"))
format closed_date %td
move closed_date dt_closed
drop dt_closed

drop ln cn db_match_confidence_level

drop if mi(nlrb_id)

replace state = "IL" if state == "Il"
replace state = "" if state == "NULL"
replace state = "" if state == "GQ"
replace state = "" if state == "KA"
replace state = "" if state == "ML"
replace state = "" if state == "NB"
replace state = "" if state == "PQ"

drop if state == "GU" | state == "VI" | state == "PR"
sort nlrb_id
drop if nlrb_id == 1
merge 1:1 nlrb_id using ../data/nlrb0509_coded_cities
drop if _merge == 1
drop _merge
drop city county

do states2.do
encode state, generate(state2) label(states2) noextend
move state2 state
rename state state_alpha2
rename state2 state

drop state_alpha2
compress

save ../data/nlrb_representation_1961_1998.dta, replace
