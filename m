From: David Miller <davem@davemloft.net>
Date: Fri, 26 Dec 2008 23:37:59 +0000
Subject: Re: [PATCH 4/5] sparc64: prepare module_64.c for unification
Message-Id: <20081226.153759.224038496.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1229984059-3743-4-git-send-email-sam@ravnborg.org>
In-Reply-To: <1229984059-3743-4-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 22 Dec 2008 23:14:18 +0100

> o Introduce a helper function
> o Combine sparc64 specific case values
> o add ifdef's around sparc64 code snippets
> 
> Note: The ifdef around the BUG_ON is highly questionable
>       but for now the safe approach was taken
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.

The ifdef for the BUG_ON is the correct thing to do.
Only sparc64 could possibly build any object with
symbols above 4GB, and that's what we're protecting
against here.
