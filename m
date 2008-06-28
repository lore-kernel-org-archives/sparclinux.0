From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 28 Jun 2008 22:29:02 +0000
Subject: Re: [GIT PULL] unify sparc header files
Message-Id: <20080628222902.GA7461@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080628220235.GA3169@uranus.ravnborg.org>
In-Reply-To: <20080628220235.GA3169@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> 
> Note:
> 406 files changed, 1986 insertions(+), 26505 deletions(-)
> This is wrong - we do not end up with 26505 less lines.
> Seems that git diff forget to add lines for copied files.

Tried to upgrade git and now I got:
406 files changed, 977 insertions(+), 26508 deletions(-)

So slightly different numbers - I did not dig into why.
But the "insertions" count seem still too low.

	Sam
