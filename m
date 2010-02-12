From: Kyle McMartin <kyle@mcmartin.ca>
Date: Fri, 12 Feb 2010 15:09:01 +0000
Subject: Re: parsic/sh/sparc tracehook breakage when tracing signals
Message-Id: <20100212150901.GH24051@bombadil.infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <201002111910.50596.vapier@gentoo.org>
In-Reply-To: <201002111910.50596.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-sh@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org

On Thu, Feb 11, 2010 at 07:10:47PM -0500, Mike Frysinger wrote:
> seems like you guys should just change the last argument to:
> 	test_thread_flag(TIF_SINGLESTEP)

Good catch, I've committed a patch to fix this, will send it upstream
today.

regards, Kyle
