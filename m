From: Aaron Wirtz <awirtz@novapointe.com>
Date: Wed, 31 Dec 2003 23:43:07 +0000
Subject: Re: socal
Message-Id: <200312311543.07514.awirtz@novapointe.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200312311429.26841.awirtz@novapointe.com>
In-Reply-To: <200312311429.26841.awirtz@novapointe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wednesday 31 December 2003 23:18, C.Newport wrote:
> Huh?  The microcode needs to be 64k in size (or less than that if you
> chop off the 0s at the end).  If you disassemble the solaris driver
> you will see that their ucode is exactly 64k and that the functions
> they call to load it expect 64k.  That value fits in an unsigned int
> on any sane platform.  Probably you've extracted the microcode
> wrongly.
> 
> However, you might as well load an ASCII-art rendition of Bill Joy,
> since even with the right microcode the driver does not work.  In
> fact, I'd recommend it.  Let us know if it helps.

lol, yeah, I know the driver is currently broken, I thought maybe if I could 
get my hands on the same version of the ucode that Jakub successfully used in 
the past, that might fix it especially if used in conjunction with Jakub's 
last functional version of the driver. (he did report actually getting it 
working once upon a time)

As for the ucode size, Jakub tried to cut the module size by storing the ucode 
in his driver without padding and just adding the padding when the driver 
loads it.  The ucode when extracted from the Solaris socal drivers I have 
tried is 64k.  Jakub recommended removing the null padding, but the code I 
get doesn't have any null padding.  If I use a full 64k of ucode in the 
compile, the preprocessor, when calculating the constant that specifies the 
offset at which the padding should start overflows because the constant is 
past the end of the buffer. (sorry, don't know what I was thinking blaming it 
on unsigned ints. ;-)  Must have been my x86 heritage...)  This issue I can 
deal with, but what worries me is that this tells me that I have not yet 
found the same version of the socal ucode that Jakub used when he wrote the 
driver.

> Unless Jakub wants to look at it or you have the manual for this chip
> and plenty of patience, forget it.

:-(

I don't have the manual, and I haven't found Jakub, but I was hoping to be 
able to diff the last working driver and start from there.

-Aaron Wirtz

