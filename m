From: "jiaqi zhang" <zation.busy@gmail.com>
Date: Thu, 16 Aug 2007 03:42:58 +0000
Subject: Re: Physical cpu number on UltrasparcT1
Message-Id: <a8e8903d0708152042q5e672eddna4ef8ac5e3976d02@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a8e8903d0708131434j1c1e2b81m5f3fb6e9c6d1a0ab@mail.gmail.com>
In-Reply-To: <a8e8903d0708131434j1c1e2b81m5f3fb6e9c6d1a0ab@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 8/15/07, David Miller <davem@davemloft.net> wrote:

>
> Check the component list from the ALOM prompt.
>
Do you mean the "showcomponent" command? I ran it and got the information:
sc> showcomponent
Keys:
  MB/CMP0/P0
  MB/CMP0/P1
  MB/CMP0/P2
  MB/CMP0/P3
  MB/CMP0/P4
  MB/CMP0/P5
  MB/CMP0/P6
  MB/CMP0/P7
  MB/CMP0/P8
  MB/CMP0/P9
  MB/CMP0/P10
  MB/CMP0/P11
  MB/CMP0/P12
  MB/CMP0/P13
  MB/CMP0/P14
  MB/CMP0/P15
  MB/CMP0/P16
  MB/CMP0/P17
  MB/CMP0/P18
  MB/CMP0/P19
  MB/CMP0/P20
  MB/CMP0/P21
  MB/CMP0/P22
  MB/CMP0/P23
  MB/CMP0/P24
  MB/CMP0/P25
  MB/CMP0/P26
  MB/CMP0/P27
  MB/CMP0/P28
  MB/CMP0/P29
  MB/CMP0/P30
  MB/CMP0/P31
  MB/CMP0/CH0/R0/D0
  MB/CMP0/CH0/R0/D1
  MB/CMP0/CH0/R1/D0
  MB/CMP0/CH0/R1/D1
  MB/CMP0/CH1/R0/D0
  MB/CMP0/CH1/R0/D1
  MB/CMP0/CH1/R1/D0
  MB/CMP0/CH1/R1/D1
  MB/CMP0/CH2/R0/D0
  MB/CMP0/CH2/R0/D1
  MB/CMP0/CH2/R1/D0
  MB/CMP0/CH2/R1/D1
  MB/CMP0/CH3/R0/D0
  MB/CMP0/CH3/R0/D1
  MB/CMP0/CH3/R1/D0
  MB/CMP0/CH3/R1/D1
  IOBD/PCIEa
  IOBD/PCIEb
  PCIX1
  PCIX0
  PCIE2
  PCIE1
  PCIE0
  IOBD/USB0
  IOBD/USB1
  IOBD/USB2
  IOBD/USB3
  DVD
  TTYA
  IOBD/GBE0
  IOBD/GBE1


State: Clean
sc> showcomponent MB/CMP0/P0
MB/CMP0/P0 is enabled

Seems not of too much help?

What should I do then?

Thanks for your patience!
