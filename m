From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 07 Dec 2008 08:24:41 +0000
Subject: Re: [RFC PATCH] sparc: expand cpu table
Message-Id: <20081207082441.GA12058@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20081206205710.GA27536@uranus.ravnborg.org>
In-Reply-To: <20081206205710.GA27536@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Dec 07, 2008 at 12:04:10AM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sat, 6 Dec 2008 21:57:10 +0100
> 
> > Prepare cputable to include sparc64 versions
> > Declare it __initconst so it can be dropped after init
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> 
> This looks good to me.
> 
> Just to clarify, this only makes the "table" itself
> 'init' not the actual strings the table refers to, right?
This is correct.
The strings end up in ".rodata.str" which is not discarded.

So the unification actually increases the size of sparc32
with the sparc64 specific strings.

	Sam
