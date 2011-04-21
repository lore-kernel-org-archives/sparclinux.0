From: David Miller <davem@davemloft.net>
Date: Thu, 21 Apr 2011 22:48:49 +0000
Subject: Re: [PATCH revised v2] sparc32: avoid build warning at
Message-Id: <20110421.154849.39168389.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110421183556.GA27199@merkur.ravnborg.org>
In-Reply-To: <20110421183556.GA27199@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 21 Apr 2011 20:35:56 +0200

> Fix following warning:
> 
> mm/percpu.c: In function 'pcpu_embed_first_chunk':
> mm/percpu.c:1647:3: warning: format '%lx' expects type 'long unsigned int', but argument 3 has type 'unsigned int'
> 
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
> [sam: added warning message to changelog, use _AC()]
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied to sparc-next-2.6, thanks.
