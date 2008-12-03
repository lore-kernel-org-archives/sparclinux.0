From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 03 Dec 2008 19:56:06 +0000
Subject: Re: GIT tree plans
Message-Id: <20081203195606.GA6432@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20081201.232300.105915235.davem@davemloft.net>
In-Reply-To: <20081201.232300.105915235.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Dec 01, 2008 at 11:23:00PM -0800, David Miller wrote:
> 
> After Linus takes in the bug fixes I just sent to him I am
> going to rebase the sparc-next-2.6 tree.
> 
> I normally wouldn't do this but there is a generic Makefile
> change from Sam that causes a bad bisection point for non-
> sparc systems so it's a good idea to get rid of that.
> 
> I normally wouldn't respin the tree like this, but to cure this
> I think it's worth it.

I just test applied the reamining five patches and only the last
one had a trivial conflict.
Let me know if you want me to post a new set of patches.

I will follow-up whith the fixed patch 5/5 on this mail.

	Sam
