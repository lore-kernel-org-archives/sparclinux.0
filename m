From: David Miller <davem@davemloft.net>
Date: Tue, 22 May 2012 20:23:56 +0000
Subject: Re: [PATCH 3/5] sparc32: implement proper LEON support in head_32 (after highmem)
Message-Id: <20120522.162356.337924428575228308.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1337717443-11904-3-git-send-email-sam@ravnborg.org>
In-Reply-To: <1337717443-11904-3-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 22 May 2012 22:10:41 +0200

> We use the compatibility property to determine the
> sun models. for leon we use psr.impl and ignore the
> result of the getprops call.
> 
> Include a hack to allow build and the support code
> is not yet converted.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Looks ok.
