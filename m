From: "David S. Miller" <davem@redhat.com>
Date: Mon, 05 Jan 2004 22:32:27 +0000
Subject: Re: [PATCH] Add sys_close to sparc64_ksyms.c
Message-Id: <20040105143227.203e52cb.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1073340739.22653.275.camel@zorak>
In-Reply-To: <1073340739.22653.275.camel@zorak>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 05 Jan 2004 16:12:19 -0600
"Tom 'spot' Callaway" <tcallawa@redhat.com> wrote:

> In order for Solaris emulation to compile in the 2.6 sparc64 tree, the
> sys_close symbol needs to be exported in sparc64_ksyms.c. This patch
> adds it.

Applied.

I wonder why the module symbol check at the end of the build was
not mentioning this in my compiles...
