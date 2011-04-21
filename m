From: David Miller <davem@davemloft.net>
Date: Thu, 21 Apr 2011 22:47:46 +0000
Subject: Re: [PATCH] sparc32: always register a PROM based early console
Message-Id: <20110421.154746.183033626.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110420211104.GA11377@merkur.ravnborg.org>
In-Reply-To: <20110420211104.GA11377@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 20 Apr 2011 23:11:04 +0200

>>From f6443589822110b80967c26ced29b5781bcec43f Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Wed, 20 Apr 2011 23:07:00 +0200
> Subject: [PATCH] sparc32: always register a PROM based early console
> 
> Do not require user to add "-p" to boot arguments to see
> early info printed to prom console.
> 
> This is similar to the sparc64 functionality - which was added with:
> 3c62a2d3477ff7725210db57aec3d2806fa10c20 ("[SPARC64]: Always register
> a PROM based early console.")
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied to sparc-next-2.6
