From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 12 Dec 2008 10:55:26 +0000
Subject: Re: help about trap_setup..
Message-Id: <20081212105526.GA32337@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <BAY117-W358094378343A8012C52A49FF80@phx.gbl>
In-Reply-To: <BAY117-W358094378343A8012C52A49FF80@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Dec 12, 2008 at 05:02:36PM +0800, Bob wrote:
> 
> Still no answer...

From the outside it looks like you are reading the assembler and 
when you encounter somthing you do not understand you trigger a mail
and then stop looking at it.

I looked myself at the curptr and could not see where gr6 is assigned,
but if I really wanted to know then I would grab another cup
of coffee and look closer.
And when I found out myself I would know more for next time,
and I would reply with the answer.
Just sitting and waitng is not the way forward with this stuff.

So I encourage you to stir at the code for some more hours.
and maybe try to patch it and see if it changes behaviour.

And when you find out please send a patch adding a comment
so the next person does not have to spend 20 hours to understand it.

Good luck,

	Sam
