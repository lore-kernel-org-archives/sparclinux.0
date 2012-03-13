From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Tue, 13 Mar 2012 23:31:05 +0000
Subject: Re: New build failures in sparc.
Message-Id: <CAP=VYLpK4txua5HRYBGmaWhzNBLnNj0xAAgshfULf-td+ouVbA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAP=VYLpfM0AFWQp7Q=xYHnCd_6vEXKKL1EL5daGcO9gsJZH=7Q@mail.gmail.com>
	<20120313.154848.265971549311147422.davem@davemloft.net>
In-Reply-To: <20120313.154848.265971549311147422.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-next@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>

On Tue, Mar 13, 2012 at 6:48 PM, David Miller <davem@davemloft.net> wrote:
> From: Paul Gortmaker <paul.gortmaker@windriver.com>
> Date: Tue, 13 Mar 2012 18:28:18 -0400
>
>> Just a heads up that these turned up today in linux-next:
>
> You must have updated your sparc binutils recently, which is now more
> strict about making sure the proper options are passed to enable v8
> instructions.

Thanks Dave, you are absolutely correct.  Stephen indicated some
toolchain updates were pending when I'd asked about mips but
it never crossed my mind again until now.

I went and looked, and last weeks build (which was OK) was using
the gcc-4.4.3 (+ whatever binutils) and the failure today is now on
gcc-4.6.3 (+ some newer binutils).

http://kisskb.ellerman.id.au/kisskb/buildresult/5826617/

vs:

http://kisskb.ellerman.id.au/kisskb/buildresult/5869520/

Paul.

---
