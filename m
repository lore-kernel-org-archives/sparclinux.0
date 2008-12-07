From: David Miller <davem@davemloft.net>
Date: Sun, 07 Dec 2008 08:27:39 +0000
Subject: Re: [RFC PATCH] sparc: expand cpu table
Message-Id: <20081207.002739.193689364.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081206205710.GA27536@uranus.ravnborg.org>
In-Reply-To: <20081206205710.GA27536@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 7 Dec 2008 09:24:41 +0100

> So the unification actually increases the size of sparc32
> with the sparc64 specific strings.

I'm fine with ifdef'ing that stuff properly.
