From: Patrick Baggett <baggett.patrick@gmail.com>
Date: Thu, 30 Jul 2015 17:31:49 +0000
Subject: Re: Debian drops support for sparc
Message-Id: <CAEk2StkmEQw3vdBiSNDrrtyYMLphWD8tBi6k=mA8HGx_G9tC8w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150730140453.GA25014@ravnborg.org>
In-Reply-To: <20150730140453.GA25014@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jul 30, 2015 at 11:48 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
>> But I think the focus should probably be on the sheer redness of the sparc
>> columns at:
>> https://release.debian.org/jessie/arch_qualify.html (current release)
>
> >From the link above:
> "
> sparc
>
> Upstream Support
>
> According to the gcc maintainer 32bit code generation as we use it is no longer supported upstream and we should aim for a switch to 64bit userland anytime soon.
> "
>
> Is it correct that 32bit gcc is no longer maintained?
> I have seen nothing on gcc mailaing list about this.
>

I've challenged this assertion, too. I don't see any evidence of it
being true. 32-bit userland makes sense for most RISC architectures
because the increased code/memory size for switching to 64-bit apps is
not justified in most cases. x86 is the weird case that 64-bit code
can run faster due to more registers, an efficient calling convention,
and %rip relative addressing. Even Solaris 10+ (which only supports
64-bit sparc kernels) has a 32-bit userland for this reason. I think
that, of all people, the gcc sparc maintainers, understand this.

I can only guess what "32bit code generation as we use it" means, but
I doubt that it means "32-bit code targeting sparcv9 ISA".
