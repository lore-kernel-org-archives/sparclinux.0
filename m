From: "C.Newport" <crn@netunix.com>
Date: Tue, 13 Jul 2004 22:38:34 +0000
Subject: Re: sparc32 status
Message-Id: <200407132338.34377.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040713160257.GA8148@foobazco.org>
In-Reply-To: <20040713160257.GA8148@foobazco.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tuesday 13 July 2004 9:41 pm, Keith M Wesolowski wrote:
> > I tracked down a man in Sun who designed this stuff and gave his contact
> > info to Keith. Sun4D should now be fixable.
>
> I'm sure he can help, especially with SMP, but most of the breakage is
> Linux-specific and has little to do with lack of hardware knowledge.
> The above example points out code that worked in 2.2 and has since
> been broken.  Under the circumstances, I can only assume the reason I
> haven't gotten a patch for this is that nobody cares.

Firstly, thanks for your effort so far, it is appreciated.

Sun4d is not a question of "nobody cares", the point is that without SMP it
is rather pointless. AIUI, SMP has never worked because nobody knew how to 
initialise the bus handling correctly due to a lack of documentation. 
This is why I tracked down the man in Sun who knows how it works. 
Once the bus handling issues are understood the rest should be almost 
identical to Sun4m.

These are really nice machines when filled with processors and memory. 
Under 2.2 with only one processor it is a power-hogging boat anchor.
With 6 processors and 1.5Gb my 1000E is almost as fast as a 4 processor
E450 running Solaris 8, and uses about the same amount of power.

BTW there is an E10k on EBay UK for 2500UKP if someone would like it for 
testing. Oldest model with only 2 system boards and 6x250MHz processors, but 
that is good enough for testing and training.

