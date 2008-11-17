From: David Miller <davem@davemloft.net>
Date: Mon, 17 Nov 2008 04:07:53 +0000
Subject: Re: [PATCH 6/8] sparc64: unify arch/sparc64/oprofile/
Message-Id: <20081116.200753.44659380.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1226866704-6485-6-git-send-email-sam@ravnborg.org>
In-Reply-To: <1226866704-6485-6-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 16 Nov 2008 21:18:22 +0100

> A simple:
> 
>    diff arch/sparc64/oprofile/init.c arch/sparc/oprofile/init.c
>    diff arch/sparc64/oprofile/Makefile arch/sparc/oprofile/Makefile
> 
> revealed that the directories were equal.
> So let sparc64 point to the sparc version and drop the sparc64 oprofile dir
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.
