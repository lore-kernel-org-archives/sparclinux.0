From: Bernd Zeimetz <bernd@bzed.de>
Date: Sat, 01 Dec 2007 13:40:25 +0000
Subject: Re: [ANNOUNCE] Aurora SPARC Linux Build 2.99 (Beta 2 for 3.0)
Message-Id: <47516449.2000600@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1196454535.3432.18.camel@localhost.localdomain>
In-Reply-To: <1196454535.3432.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: Bernd Zeimetz <bernd@bzed.de>
> Date: Sat, 01 Dec 2007 13:43:30 +0100
> 
>>>> - Systems that boot off qlogic attached disks are not supported, because 
>>>> there is no working firmware loader in anaconda, and the qlogic driver 
>>>> needs firmware.
>>> That's very unfortunate, how are qlogic device handled on other
>>> platforms?
>> In Debian you just install the firmware package, udevl will handle it
>> then. If you have to boot from it, you need to rebuild your initrd after
>> installing the firmware package.
>> The installer doesn't support non-free modules yet unfortunately, but
>> with some not too complicated tricks you can install Debian without
>> problems.
> 
> I said "other platforms" as in x86, x86_64, powerpc.

Just the same. You can even install the firmware on hardware where you
wouldn't be able use a qlogic card. It's only loaded if an appropriate
device is detected.

-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>
