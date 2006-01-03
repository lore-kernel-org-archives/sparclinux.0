From: Ben Collins <ben.collins@ubuntu.com>
Date: Tue, 03 Jan 2006 00:55:14 +0000
Subject: Re: SILO 1.4.10
Message-Id: <1136249714.27583.68.camel@grayson>
List-Id: <sparclinux.vger.kernel.org>
References: <1136175018.27583.50.camel@grayson>
In-Reply-To: <1136175018.27583.50.camel@grayson>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2006-01-02 at 16:00 -0800, Jim Gifford wrote:
> I verified the only file not being built correctly is second.b. I used 
> hexdump to create a hexdump of the second.b from silo-loaders-1.4.10 and 
> the one I compiled. It looks like everything is shifted.
> 
> http://ftp.jg555.com/diff_of_hex_dump

Are you compiling this as 64-bit or 32-bit? All I know is this has to be
something with your toolchain. I've compiled this just fine with several
compilers and several binutils (gcc-3.4, gcc-4.0).

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

