-- Example only, for parser tests
opts = {
   {
      name = "Clock Source",
      bytes = { 1 , 2 , 3 }, -- byte numbers in payload
      mask = {0xff, 0xff, 0xff }, -- mask out effective bits
      values = { 
	 { 
	    name = "On-Chip oscillator",
	    value = {0xfa, 0xfb, 0xfc},
	 },
	 { 
	    name = "External Crystal",
	    value = {0xfd, 0xfd, 0xfd},
	 },
      }
   },
}

mcudb = {
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	8K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWM\
",
      iram="0xFF",
      irom="0x1FFF",
      magic="D164",
      name="STC12C5A08S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	16K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMk\
",
      iram="0xFF",
      irom="0x3FFF",
      magic="D168",
      name="STC12C5A16S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	32K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMm\
",
      iram="0xFF",
      irom="0x7FFF",
      magic="D170",
      name="STC12C5A32S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	40K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMn\
",
      iram="0xFF",
      irom="0x9FFF",
      magic="D174",
      name="STC12C5A40S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	48K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMf\
",
      iram="0xFF",
      irom="0xBFFF",
      magic="D178",
      name="STC12C5A48S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	52K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMk\
",
      iram="0xFF",
      irom="0xCFFF",
      magic="D17A",
      name="STC12C5A52S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	56K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMg\
",
      iram="0xFF",
      irom="0xDFFF",
      magic="D17C",
      name="STC12C5A56S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	60K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMl\
",
      iram="0xFF",
      irom="0xEFFF",
      magic="D17E",
      name="STC12C5A60S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	8K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWMg\
",
      iram="0xFF",
      irom="0x1FFF",
      magic="D144",
      name="STC12C5A08AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	16K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWM6\
",
      iram="0xFF",
      irom="0x3FFF",
      magic="D148",
      name="STC12C5A16AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	32K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWM8\
",
      iram="0xFF",
      irom="0x7FFF",
      magic="D150",
      name="STC12C5A32AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	40K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWM9\
",
      iram="0xFF",
      irom="0x9FFF",
      magic="D154",
      name="STC12C5A40AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	48K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWM1\
",
      iram="0xFF",
      irom="0xBFFF",
      magic="D158",
      name="STC12C5A48AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	52K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWM6\
",
      iram="0xFF",
      irom="0xCFFF",
      magic="D15A",
      name="STC12C5A52AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	56K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWM2\
",
      iram="0xFF",
      irom="0xDFFF",
      magic="D15C",
      name="STC12C5A56AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	60K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWM7\
",
      iram="0xFF",
      irom="0xEFFF",
      magic="D15E",
      name="STC12C5A60AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	8K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, CCP/PWMq\
",
      iram="0xFF",
      irom="0x1FFF",
      magic="D124",
      name="STC12C5A08CCP",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	16K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, CCP/PWM@\
",
      iram="0xFF",
      irom="0x3FFF",
      magic="D128",
      name="STC12C5A16CCP",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	32K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, CCP/PWMB\
",
      iram="0xFF",
      irom="0x7FFF",
      magic="D130",
      name="STC12C5A32CCP",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	40K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, CCP/PWMC\
",
      iram="0xFF",
      irom="0x9FFF",
      magic="D134",
      name="STC12C5A40CCP",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	48K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, CCP/PWM;\
",
      iram="0xFF",
      irom="0xBFFF",
      magic="D138",
      name="STC12C5A48CCP",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	52K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, CCP/PWM@\
",
      iram="0xFF",
      irom="0xCFFF",
      magic="D13A",
      name="STC12C5A52CCP",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	56K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, CCP/PWM<\
",
      iram="0xFF",
      irom="0xDFFF",
      magic="D13C",
      name="STC12C5A56CCP",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	60K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, CCP/PWMA\
",
      iram="0xFF",
      irom="0xEFFF",
      magic="D13E",
      name="STC12C5A60CCP",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      magic="D104",
      name="STC12C5A08X",
      tested={  } 
    },
    {
      magic="D108",
      name="STC12C5A16X",
      tested={  } 
    },
    {
      magic="D110",
      name="STC12C5A32X",
      tested={  } 
    },
    {
      magic="D114",
      name="STC12C5A40X",
      tested={  } 
    },
    {
      magic="D118",
      name="STC12C5A48X",
      tested={  } 
    },
    {
      magic="D11A",
      name="STC12C5A52X",
      tested={  } 
    },
    {
      magic="D11C",
      name="STC12C5A56X",
      tested={  } 
    },
    {
      magic="D11E",
      name="STC12C5A60X",
      tested={  } 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	8K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWM\
",
      iram="0xFF",
      irom="0x1FFF",
      magic="D1E4",
      name="STC12LE5A08S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	16K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMk\
",
      iram="0xFF",
      irom="0x3FFF",
      magic="D1E8",
      name="STC12LE5A16S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	32K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMm\
",
      iram="0xFF",
      irom="0x7FFF",
      magic="D1F0",
      name="STC12LE5A32S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	40K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMn\
",
      iram="0xFF",
      irom="0x9FFF",
      magic="D1F4",
      name="STC12LE5A40S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	48K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMf\
",
      iram="0xFF",
      irom="0xBFFF",
      magic="D1F8",
      name="STC12LE5A48S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	52K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMk\
",
      iram="0xFF",
      irom="0xCFFF",
      magic="D1FA",
      name="STC12LE5A52S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	56K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMg\
",
      iram="0xFF",
      irom="0xDFFF",
      magic="D1FC",
      name="STC12LE5A56S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	60K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMl\
",
      iram="0xFF",
      irom="0xEFFF",
      magic="D1FE",
      name="STC12LE5A60S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	8K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWMg\
",
      iram="0xFF",
      irom="0x1FFF",
      magic="D1C4",
      name="STC12LE5A08AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	16K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWM6\
",
      iram="0xFF",
      irom="0x3FFF",
      magic="D1C8",
      name="STC12LE5A16AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	32K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWM8\
",
      iram="0xFF",
      irom="0x7FFF",
      magic="D1D0",
      name="STC12LE5A32AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	40K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWM9\
",
      iram="0xFF",
      irom="0x9FFF",
      magic="D1D4",
      name="STC12LE5A40AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	48K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWM1\
",
      iram="0xFF",
      irom="0xBFFF",
      magic="D1D8",
      name="STC12LE5A48AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	52K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWM6\
",
      iram="0xFF",
      irom="0xCFFF",
      magic="D1DA",
      name="STC12LE5A52AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	56K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWM2\
",
      iram="0xFF",
      irom="0xDFFF",
      magic="D1DC",
      name="STC12LE5A56AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	60K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWM7\
",
      iram="0xFF",
      irom="0xEFFF",
      magic="D1DE",
      name="STC12LE5A60AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	8K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, CCP/PWMq\
",
      iram="0xFF",
      irom="0x1FFF",
      magic="D1A4",
      name="STC12LE5A08CCP",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	16K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, CCP/PWM@\
",
      iram="0xFF",
      irom="0x3FFF",
      magic="D1A8",
      name="STC12LE5A16CCP",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	32K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, CCP/PWMB\
",
      iram="0xFF",
      irom="0x7FFF",
      magic="D1B0",
      name="STC12LE5A32CCP",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	40K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, CCP/PWMC\
",
      iram="0xFF",
      irom="0x9FFF",
      magic="D1B4",
      name="STC12LE5A40CCP",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	48K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, CCP/PWM;\
",
      iram="0xFF",
      irom="0xBFFF",
      magic="D1B8",
      name="STC12LE5A48CCP",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	52K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, CCP/PWM@\
",
      iram="0xFF",
      irom="0xCFFF",
      magic="D1BA",
      name="STC12LE5A52CCP",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	56K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, CCP/PWM<\
",
      iram="0xFF",
      irom="0xDFFF",
      magic="D1BC",
      name="STC12LE5A56CCP",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	60K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, CCP/PWMA\
",
      iram="0xFF",
      irom="0xEFFF",
      magic="D1BE",
      name="STC12LE5A60CCP",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      magic="D184",
      name="STC12LE5A08X",
      tested={  } 
    },
    {
      magic="D188",
      name="STC12LE5A16X",
      tested={  } 
    },
    {
      magic="D190",
      name="STC12LE5A32X",
      tested={  } 
    },
    {
      magic="D194",
      name="STC12LE5A40X",
      tested={  } 
    },
    {
      magic="D198",
      name="STC12LE5A48X",
      tested={  } 
    },
    {
      magic="D19A",
      name="STC12LE5A52X",
      tested={  } 
    },
    {
      magic="D19C",
      name="STC12LE5A56X",
      tested={  } 
    },
    {
      magic="D19E",
      name="STC12LE5A60X",
      tested={  } 
    },
    {
      magic="D163",
      name="IAP12C5A08S2",
      tested={  } 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	16K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMk\
",
      iram="0xFF",
      irom="0x3FFF",
      magic="D167",
      name="IAP12C5A16S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	32K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMm\
",
      iram="0xFF",
      irom="0x7FFF",
      magic="D16F",
      name="IAP12C5A32S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      magic="D173",
      name="IAP12C5A40S2",
      tested={  } 
    },
    {
      magic="D177",
      name="IAP12C5A48S2",
      tested={  } 
    },
    {
      magic="D179",
      name="IAP12C5A52S2",
      tested={  } 
    },
    {
      magic="D17B",
      name="IAP12C5A56S2",
      tested={  } 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	60K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMl\
",
      iram="0xFF",
      irom="0xEFFF",
      magic="D17D",
      name="IAP12C5A60S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	62K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMj\
",
      iram="0xFF",
      irom="0xF7FF",
      magic="D17F",
      name="IAP12C5A62S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      magic="D143",
      name="IAP12C5A08AD",
      tested={  } 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	16K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWM6\
",
      iram="0xFF",
      irom="0x3FFF",
      magic="D147",
      name="IAP12C5A16AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	32K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWM8\
",
      iram="0xFF",
      irom="0x7FFF",
      magic="D14F",
      name="IAP12C5A32AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      magic="D153",
      name="IAP12C5A40AD",
      tested={  } 
    },
    {
      magic="D157",
      name="IAP12C5A48AD",
      tested={  } 
    },
    {
      magic="D159",
      name="IAP12C5A52AD",
      tested={  } 
    },
    {
      magic="D15B",
      name="IAP12C5A56AD",
      tested={  } 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	60K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWM7\
",
      iram="0xFF",
      irom="0xEFFF",
      magic="D15D",
      name="IAP12C5A60AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	62K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWM5\
",
      iram="0xFF",
      irom="0xF7FF",
      magic="D15F",
      name="IAP12C5A62AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      magic="D123",
      name="IAP12C5A08CCP",
      tested={  } 
    },
    {
      magic="D127",
      name="IAP12C5A16CCP",
      tested={  } 
    },
    {
      magic="D12F",
      name="IAP12C5A32CCP",
      tested={  } 
    },
    {
      magic="D133",
      name="IAP12C5A40CCP",
      tested={  } 
    },
    {
      magic="D137",
      name="IAP12C5A48CCP",
      tested={  } 
    },
    {
      magic="D139",
      name="IAP12C5A52CCP",
      tested={  } 
    },
    {
      magic="D13B",
      name="IAP12C5A56CCP",
      tested={  } 
    },
    {
      magic="D13D",
      name="IAP12C5A60CCP",
      tested={  } 
    },
    {
      magic="D13F",
      name="IAP12C5A62CCP",
      tested={  } 
    },
    {
      magic="D103",
      name="IAP12C5A08",
      tested={  } 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	16K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMk\
",
      iram="0xFF",
      irom="0x3FFF",
      magic="D107",
      name="IAP12C5A16",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	32K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMm\
",
      iram="0xFF",
      irom="0x7FFF",
      magic="D10F",
      name="IAP12C5A32",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      magic="D113",
      name="IAP12C5A40",
      tested={  } 
    },
    {
      magic="D117",
      name="IAP12C5A48",
      tested={  } 
    },
    {
      magic="D119",
      name="IAP12C5A52",
      tested={  } 
    },
    {
      magic="D11B",
      name="IAP12C5A56",
      tested={  } 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	60K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMl\
",
      iram="0xFF",
      irom="0xEFFF",
      magic="D11D",
      name="IAP12C5A60",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	62K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMj\
",
      iram="0xFF",
      irom="0xF7FF",
      magic="D11F",
      name="IAP12C5A62",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      magic="D1E3",
      name="IAP12LE5A08S2",
      tested={  } 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	16K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMk\
",
      iram="0xFF",
      irom="0x3FFF",
      magic="D1E7",
      name="IAP12LE5A16S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	32K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMm\
",
      iram="0xFF",
      irom="0x7FFF",
      magic="D1EF",
      name="IAP12LE5A32S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      magic="D1F3",
      name="IAP12LE5A40S2",
      tested={  } 
    },
    {
      magic="D1F7",
      name="IAP12LE5A48S2",
      tested={  } 
    },
    {
      magic="D1F9",
      name="IAP12LE5A52S2",
      tested={  } 
    },
    {
      magic="D1FB",
      name="IAP12LE5A56S2",
      tested={  } 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	60K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMl\
",
      iram="0xFF",
      irom="0xEFFF",
      magic="D1FD",
      name="IAP12LE5A60S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	62K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMj\
",
      iram="0xFF",
      irom="0xF7FF",
      magic="D1FF",
      name="IAP12LE5A62S2",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      magic="D1C3",
      name="IAP12LE5A08AD",
      tested={  } 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	16K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWM6\
",
      iram="0xFF",
      irom="0x3FFF",
      magic="D1C7",
      name="IAP12LE5A16AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	32K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWM8\
",
      iram="0xFF",
      irom="0x7FFF",
      magic="D1CF",
      name="IAP12LE5A32AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      magic="D1D3",
      name="IAP12LE5A40AD",
      tested={  } 
    },
    {
      magic="D1D7",
      name="IAP12LE5A48AD",
      tested={  } 
    },
    {
      magic="D1D9",
      name="IAP12LE5A52AD",
      tested={  } 
    },
    {
      magic="D1DB",
      name="IAP12LE5A56AD",
      tested={  } 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	60K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWM7\
",
      iram="0xFF",
      irom="0xEFFF",
      magic="D1DD",
      name="IAP12LE5A60AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	62K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, UART, WDT, ISP/IAP, A/D, CCP/PWM5\
",
      iram="0xFF",
      irom="0xF7FF",
      magic="D1DF",
      name="IAP12LE5A62AD",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      magic="D1A3",
      name="IAP12LE5A08CCP",
      tested={  } 
    },
    {
      magic="D1A7",
      name="IAP12LE5A16CCP",
      tested={  } 
    },
    {
      magic="D1AF",
      name="IAP12LE5A32CCP",
      tested={  } 
    },
    {
      magic="D1B3",
      name="IAP12LE5A40CCP",
      tested={  } 
    },
    {
      magic="D1B7",
      name="IAP12LE5A48CCP",
      tested={  } 
    },
    {
      magic="D1B9",
      name="IAP12LE5A52CCP",
      tested={  } 
    },
    {
      magic="D1BB",
      name="IAP12LE5A56CCP",
      tested={  } 
    },
    {
      magic="D1BD",
      name="IAP12LE5A60CCP",
      tested={  } 
    },
    {
      magic="D1BF",
      name="IAP12LE5A62CCP",
      tested={  } 
    },
    {
      magic="D183",
      name="IAP12LE5A08",
      tested={  } 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	16K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMk\
",
      iram="0xFF",
      irom="0x3FFF",
      magic="D187",
      name="IAP12LE5A16",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	32K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMm\
",
      iram="0xFF",
      irom="0x7FFF",
      magic="D18F",
      name="IAP12LE5A32",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      magic="D193",
      name="IAP12LE5A40",
      tested={  } 
    },
    {
      magic="D197",
      name="IAP12LE5A48",
      tested={  } 
    },
    {
      magic="D199",
      name="IAP12LE5A52",
      tested={  } 
    },
    {
      magic="D19B",
      name="IAP12LE5A56",
      tested={  } 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	60K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMl\
",
      iram="0xFF",
      irom="0xEFFF",
      magic="D19D",
      name="IAP12LE5A60",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    },
    {
      descr="	8051-based microcontroller with 1T(1-clock) High-Speed Core,\
	Dual DPTR, 36-44 I/O Lines, 2 Timers/Counters, 2 PCA Timers,\
	Alternative build-in oscillator,\
	Independent Baud Rate Generator, Programmable Clock-Out,\
	62K bytes flash ROM, 1280 bytes data RAM,\
	On-chip EEPROM, 2 UARTs, WDT, ISP/IAP, A/D, CCP/PWMj\
",
      iram="0xFF",
      irom="0xF7FF",
      magic="D19F",
      name="IAP12LE5A62",
      speed="45000000",
      tested={  },
      xram="0x3FF" 
    } 
  }