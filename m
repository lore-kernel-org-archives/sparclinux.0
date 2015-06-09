From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Tue, 09 Jun 2015 21:29:43 +0000
Subject: Re: netboot failure with current kernels?
Message-Id: <20150609212943.GA1259@aspire-one.musicnaut.iki.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1506021937230.9956@math.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1506021937230.9956@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

On Tue, Jun 02, 2015 at 07:50:19PM +0300, Meelis Roos wrote:
> I tried to install Debian on my E280R. Netboot is the most natural way 
> for remote install so I tried that. Current Debian installer fails to 
> load:
> 
> {0} ok boot net
> Boot device: /pci@8,700000/network@5,1:  File and args: 
> Timeout waiting for ARP/RARP packet
> 4000 \
>      ERROR: /packages/obp-tftp: Last Trap: Fast Data Access MMU Miss
> 
> 
> Boot load failed
> 
> Is this some known problem with TFTP booting that Debian needs to fix, 
> or something new? Size of the boot.img file is 12988928 bytes, OBP 
> version 4.16.4 2004/12/18.

Probably the image is too big. At least on older sparcs the limit
is 10 MB.

A.
