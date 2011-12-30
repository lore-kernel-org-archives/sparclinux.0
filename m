From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 30 Dec 2011 14:10:33 +0000
Subject: Re: [PATCH] sparc32: remove unused file: include/asm/pgtsun4.h
Message-Id: <20111230141033.GA4675@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20111230123521.GA4478@merkur.ravnborg.org>
In-Reply-To: <20111230123521.GA4478@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Dec 30, 2011 at 11:44:28PM +1100, Julian Calaby wrote:
> Sam,
> 
> I understand if this isn't used at all, but this seems to be Sun4C
> stuff, so why isn't it used - are these defines defined elsewhere?

The SUN4C stuff is defined in arch/sparc/include/asm/pgtsun4c.h

	Sam
