From: Julian Calaby <julian.calaby@gmail.com>
Date: Mon, 02 Feb 2009 13:24:55 +0000
Subject: Re: make ARCH=sparc allmodconfig change
Message-Id: <646765f40902020524h20c19c5ex6f697fa979931b49@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20090201190029.GA8962@x200.localdomain>
In-Reply-To: <20090201190029.GA8962@x200.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Feb 2, 2009 at 16:48, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Sun, Feb 01, 2009 at 09:51:13PM +0000, Mark Fortescue wrote:
>> Hi all.
>>
>> Silly question. If ARCH=sparc is not 64bit then how do you make a 32bit
>> sparc kernel?
>
> make arch=sparc menuconfig give you the option to select
> if the kernel is 64 bit or not.
>
> And this "64 bit?" option is what is causing us troubles for the
> all*config targets.
> allyesconfig and allmodconfig will both set this option to 'y'
> so we cannot in any simple way generate a 32bit all{yes,mod}config.

Why not have a sparc32 arch also, which would force 64bit to false. So:
1. If we detect a 32 bit sparc, we select sparc32.
2. If we detect a 64 bit sparc, we select sparc64.
3. Otherwise we select sparc and let the user decide.

I believe that powerpc also works in this manner, as does x86.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
.Plan: http://sites.google.com/site/juliancalaby/
