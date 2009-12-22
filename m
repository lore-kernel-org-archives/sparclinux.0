From: Jan Engelhardt <jengelh@medozas.de>
Date: Tue, 22 Dec 2009 19:25:45 +0000
Subject: Re: Checking for v9v/64v capability
Message-Id: <alpine.LSU.2.01.0912222021380.18129@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912220054220.25079@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912220054220.25079@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Tuesday 2009-12-22 20:11, David Miller wrote:
>
>> As far as I can tell, sparcv9v packages are not created in an
>> sparcv9-incompatible way.
>> 
>> $ grep -r niagara /usr/lib/rpm
>> /usr/lib/rpm/rpmrc:optflags: sparcv9v -O2 -g -m32 -mtune=niagara
>> /usr/lib/rpm/rpmrc:optflags: sparc64v -O2 -g -m64 -mtune=niagara
>> 
>> It only uses -mtune, not -mcpu. Or did I err somewhere in this regard?
>
>-mcpu with sparc64 chip names would turn on 64-bit code generation.

But there is no -mcpu here. Just -mtune. Hence it should be producing
V7/V8/V8+-compatible code, with niagara-chosen instruction
scheduling/etc.


>Or at least, it did at one point.

You are probably thinking of GCC's ./configure which, when called
with --with-cpu=ultrasparc will result in a gcc producing ELF64
objects by default, while --with-cpu=v8 will lead to ELF32 output.
