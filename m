From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 11 Jan 2011 05:44:23 +0000
Subject: Re: [PATCH] atyfb: Fix bootup hangs on sparc64.
Message-Id: <20110111054423.GA25114@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110105.130959.260100853.davem@davemloft.net>
In-Reply-To: <20110105.130959.260100853.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Jan 10, 2011 at 02:13:42PM -0800, David Miller wrote:
> 
> In order to attack this better, can you possibly get the
> ".properties" output from the framebuffer device node?
> 
> Something like:
> 
> ok cd /pci@1f,0/SUNW,m64B@13
> ok .properties
> 
> at the firmware prompt right after reset should do the trick.

Here you go:
ok cd SUNW,m64B
ok .properties
address                  fde00000
assigned-addresses       82009810 00000000 03000000 00000000 01000000
                         81009814 00000000 00000b00 00000000 00000100
                         82009818 00000000 00426000 00000000 00002000
                         82009830 00000000 00440000 00000000 00020000
aty,fcode                1.69
aty,card#                109-XXXXX-XX
aty,rom#                 113-XXXXX-100
model                    ATY,RageXL
name                     SUNW,m64B
pgx_version              @(#) pgx24+.fth 1.6 01/02/06
reg                      00009800 00000000 00000000 00000000 00000000
                         02009810 00000000 00000000 00000000 01000000
                         02009818 00000000 00000000 00000000 00001000
                         02009830 00000000 00000000 00000000 00020000
character-set            ISO8859-1
device_type              display
linebytes                00 00 04 00
depth                    00 00 00 08
height                   00 00 03 00
width                    00 00 04 00
fb-memory                00 00 00 08
aty,flags                00 00 00 00
aty,status               00 00 00 04
fast-back-to-back
devsel-speed             00000001
class-code               00030000
interrupts               00000001
latency-timer            00000040
cache-line-size          00000010
max-latency              00000000
min-grant                00000008
revision-id              00000027
device-id                00004752
vendor-id                00001002


I am away for a few days (business trip) - so eventual feedback is delayed :-(

PS. Thanks for putting time into such an ancient system!

	Sam
