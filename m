From: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
Date: Thu, 20 May 2004 12:50:54 +0000
Subject: Re: [LONG] Problem with Sun Enterprise 450 and kernel 2.6.X
Message-Id: <Pine.LNX.4.58L.0405201447110.6247@alpha.zarz.agh.edu.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.58L.0405151812370.18060@alpha.zarz.agh.edu.pl>
In-Reply-To: <Pine.LNX.4.58L.0405151812370.18060@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 15 May 2004, Patrick Finnegan wrote:
[...]
> Try to boot with the "-p" kernel option.  This will cause "early printk" 
> to be available, so that messages/errors before the console is 
> initialized will be available.
> 
> I had an issue like this with my E3000, and it turned out to be a small 
> kernel bug combined with the fact that I had set NR_CPUS too small in 
> the kernel config, however, I don't think that you should have that 
> problem with your E450.

I try, and found, that kernel works ...
But I got warning - Unable to open initial console"
It's strange for me
- I have /dev/console on my system
and I have this setting:

CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
# CONFIG_PROM_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=m
CONFIG_PCI_CONSOLE=y
CONFIG_SERIAL_SUNZILOG_CONSOLE=y
CONFIG_SERIAL_SUNSU_CONSOLE=y
CONFIG_SERIAL_CORE_CONSOLE=y


Any sugesstion ??

Thanx.
					Sas.
-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}
