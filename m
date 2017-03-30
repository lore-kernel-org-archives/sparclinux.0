From: Olliver Schinagl <oliver@schinagl.nl>
Date: Thu, 30 Mar 2017 06:43:38 +0000
Subject: Re: [PATCH] serial: Do not treat the IIR register as a bitfield
Message-Id: <D694FA74-1F31-4B57-8858-2DBE8DE57D45@schinagl.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <20170329184431.6226-1-oliver@schinagl.nl> <6be65e8b-eea4-08ed-0b30-5c0608764a83@ti.com>
In-Reply-To: <6be65e8b-eea4-08ed-0b30-5c0608764a83@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vignesh R <vigneshr@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Laxman Dewangan <ldewangan@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "David S . Miller" <davem@davemloft.net>
Cc: "dev@linux-sunxi.org" <dev@linux-sunxi.org>, Ed Blake <ed.blake@imgtec.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alexander Sverdlin <alexander.sverdlin@nokia.com>, Yegor Yefremov <yegorslists@googlemail.com>, Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiko Stuebner <heiko@sntech.de>, Jason Uy <jason.uy@broadcom.com>, Douglas Anderson <dianders@chromium.org>, Peter Hurley <peter@hurleysoftware.com>, Tony Lindgren <tony@atomide.com>, Thor Thayer <tthayer@opensource.altera.com>, David Lechner <david@lechnology.com>, Jan Kiszka <jan.kiszka@siemens.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>



On March 30, 2017 8:15:29 AM CEST, Vignesh R <vigneshr@ti.com> wrote:
>Hi,
>
>On Thursday 30 March 2017 12:14 AM, Olliver Schinagl wrote:
>> diff --git a/include/uapi/linux/serial_reg.h
>b/include/uapi/linux/serial_reg.h
>> index 5db76880b4ad..489522389a10 100644
>> --- a/include/uapi/linux/serial_reg.h
>> +++ b/include/uapi/linux/serial_reg.h
>> @@ -31,18 +31,18 @@
>>  #define UART_IERX_SLEEP		0x10 /* Enable sleep mode */
>>  
>>  #define UART_IIR	2	/* In:  Interrupt ID Register */
>> -#define UART_IIR_NO_INT		0x01 /* No interrupts pending */
>> -#define UART_IIR_ID		0x0e /* Mask for the interrupt ID */
>>  #define UART_IIR_MSI		0x00 /* Modem status interrupt */
>> +#define UART_IIR_NO_INT		0x01 /* No interrupts pending */
>>  #define UART_IIR_THRI		0x02 /* Transmitter holding register empty */
>>  #define UART_IIR_RDI		0x04 /* Receiver data interrupt */
>>  #define UART_IIR_RLSI		0x06 /* Receiver line status interrupt */
>> -
>>  #define UART_IIR_BUSY		0x07 /* DesignWare APB Busy Detect */
>> +#define UART_IIR_RX_TIMEOUT	0x0c /* DesignWare RX Timeout interrupt
>*/
It was moved due to sorting. The comment could be changed maybe? I renamed it from omap to dw as i believe the omap also uses the dw ip. But i think it is a defacto standard mapping of the irr register?

>> +#define UART_IIR_MASK		0x0f /* DesignWare IIR mask */
>>  
>> -#define UART_IIR_RX_TIMEOUT	0x0c /* OMAP RX Timeout interrupt */
>
>You are removing UART_IIR_RX_TIMEOUT? Is this intended?
>
>>  #define UART_IIR_XOFF		0x10 /* OMAP XOFF/Special Character */
>>  #define UART_IIR_CTS_RTS_DSR	0x20 /* OMAP CTS/RTS/DSR Change */
>> +#define UART_IIR_EXT_MASK	0x30 /* OMAP extended IIR mask */

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
