From: James Morris <jmorris@namei.org>
Date: Wed, 28 Apr 2010 22:59:15 +0000
Subject: Re: [PATCH] Disable execmem for sparc
Message-Id: <alpine.LRH.2.00.1004290859010.1488@tundra.namei.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4BAA89B9.2030102@redhat.com>
In-Reply-To: <4BAA89B9.2030102@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 28 Apr 2010, Stephen Smalley wrote:

> To avoid maintaining per-arch ifdefs, it seems that we could just
> directly use (VM_DATA_DEFAULT_FLAGS & VM_EXEC) as the basis for deciding
> whether to enable or disable these checks.   VM_DATA_DEFAULT_FLAGS isn't
> constant on some architectures but instead depends on
> current->personality, but we want this applied uniformly.  So we'll just
> use the initial task state to determine whether or not to enable these
> checks.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>


Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next


-- 
James Morris
<jmorris@namei.org>
