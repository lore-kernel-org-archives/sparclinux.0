From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 17 Nov 2008 22:28:20 +0000
Subject: Re: sparc unification step 3
Message-Id: <20081117222820.GA14932@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20081117220200.GA14667@uranus.ravnborg.org>
In-Reply-To: <20081117220200.GA14667@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Nov 17, 2008 at 11:02:00PM +0100, Sam Ravnborg wrote:
> This is the thrid step in the unification.
> This time it includes:
> 
>  - unification of sparc{,64}/prom/
>  - unification of arch Makefiles
>  - unification of sparc{,64}/kernel

Having done the unification of kernel/ I have started
wondering if this is the right approach.
Initially I did a diff of all the identical named
files in sparc/kernel/, sparc64/kernel/ and noone
showed up as easy unification targets.

Maybe I did not look close enough - I only judged on the diffstat output.

Would it make more sense to use two directories:
kernel32/
kernel64/

And accept that 32 and 64 bit do not share code?

We would anyway continue to have kernel/
as the build system require this - and here we could
have the shared files as linking order permits.

Same thinking goes with lib/ and boot/ which is the main reason
I did not unify them yet.

Let me know what you think.

I will redo my patches as needed should we go for the
kernel32/ kernel64/ model.

Patches 1 and 2 can be applied anyway as I do not
see a reason for a prom32 / prom64 split.

	Sam
