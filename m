From: Sunil Amitkumar Janki <devel.sjanki@gmail.com>
Date: Thu, 13 Sep 2007 13:01:12 +0000
Subject: Re: Is Sun putting much effort into supporting the gcc/binutils toolchain
Message-Id: <46E93498.2080102@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <46E7CF5F.3090909@walrond.org>
In-Reply-To: <46E7CF5F.3090909@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Chris Newport wrote:
> Sunil Amitkumar Janki wrote:
>
>>
>> GCC for SPARC is a front end to this compiler, which isn't available
>> for Linux/SPARC so not really useful at all. If Sun Studio were 
>> available
>> for GNU/Linux SPARC this front end would probably function the same as
>> on Solaris, maybe even without any changes at all.
>>
>> I don't know if the source code to this front end has been released 
>> in the
>> open or if it is even useful to the GCC project in general and to 
>> GNU/Linux
>> on SPARC in particular.
>>
> gcc and the GNU toolchain for Solaris can be found at 
> http://www.sunfreeware.com/ which is sponsored by Sun.
>
> This contains all of the hardware related stuff, so it should not be
> difficult to recompile for sparclinux.  All under GPL of course.

I am sorry if I wasn't clear in my reasoning. I know that
GCC and the GNU toolchain is available for both Linux and
Solaris on SPARC.

What I was talking about is http://cooltools.sunsource.net/gcc
and a discussion about this can be found in the GCC mailing list
archives:

http://gcc.gnu.org/ml/gcc/2006-03/msg00140.html

Sunil

