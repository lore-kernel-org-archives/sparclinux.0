From: Aaron Wirtz <awirtz@novapointe.com>
Date: Thu, 01 Jan 2004 03:10:18 +0000
Subject: Re: socal
Message-Id: <200312311910.18815.awirtz@novapointe.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200312311429.26841.awirtz@novapointe.com>
In-Reply-To: <200312311429.26841.awirtz@novapointe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wednesday 31 December 2003 16:26, Keith M Wesolowski wrote:
> On Wed, Dec 31, 2003 at 04:19:24PM -0800, Aaron Wirtz wrote:
> > here's the procedure I'm using:
> > (socal is the driver copied from solaris)
> >
> > $ nm socal
> > ---unimportant lines removed---
> > 0000360c t socal_transport_poll
> > 000002a0 D socal_ucode
> > 000102a0 D socal_ucode_end
> > 00004f0c t socal_us_els
> > ---unimportant lines removed---
> > $ dd bs=1 skipg2 counte536 if=socal of=socal.ucode
> > 65536+0 records in
> > 65536+0 records out
> > 65536 bytes transferred in 2.512516 seconds (26084 bytes/sec)
> >
> >
> > Then I used Jakub's sed command to make the header.
> > If I hexedit the socal.ucode file I see the same thing as I see in the .h
> > file, so I know that the sed step works fine.
>
> It's wrong.  An offset of 2a0 into the .rodata section is not the same
> as an offset of 2a0 into the binary on disk.  Use readelf and/or
> objdump to figure out where the ucode actually starts.
>
> Also, the stuff you'll get with his script is in bytes, so it should
> be u8 not u32.

I am using bs=1, so it is counting in bytes.

After looking more closely, I realized that you are right; I was using the 
data offset, not the file offset.  After a bit of fiddling, I have a command 
that seems to extract the ucode properly from the solaris binary driver.  If 
anyone wants to incorporate this into a FAQ, be my guest. (Or if I ever get 
the whole thing working, I'll write a HOWTO.)

perl -e'($o,$s,$l)=(split /\s+/,(grep{/\s$ARGV[1]$/}(split /\n/,
`objdump -t $ARGV[0]`))[0])[0,3,4];$o=hex($o)+hex((split /\s+/,(grep{
/\s$s\s/}(split /\n\s*/,`objdump -h $ARGV[0]`))[0])[5]);open I,$ARGV[0];
seek I,$o,0;read I,$d,hex($l);$d=~s/\x00+$//s;open O,">$ARGV[2]";print
O "static __u32 socal_ucode[] __initdata = {\n";for(split "",$d){print
O "0x".unpack("h2",$_).(++$c%16=0?",\n":",")}print O "};\n"' \
socal socal_ucode socal_asm.h

The last three arguments specify input file, the symbol name, and the output 
file respectively.  This will strip null padding as well.  If you want to use 
it for other purposes, removing the "$d=~s/\x00+$//s;" command will leave 
null padding on the data.

I will do a compile and will try the driver on Monday.

Thanks.

-Aaron Wirtz

