From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 06 Mar 2013 16:11:46 +0000
Subject: Re: [PATCH v1] [SPARC64] correctly recognize SPARC64-X chips
Message-Id: <20130306161146.GB13449@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1362563279-23839-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1362563279-23839-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Mar 06, 2013 at 03:17:59PM +0530, Allen Pais wrote:
> The following patch adds support for correctly
> recognizing SPARC-X chips.
> 
> cpu : Unknown SUN4V CPU
> fpu : Unknown SUN4V FPU
> pmu : Unknown SUN4V PMU
> 
> Signed-off-by: Katayama Yoshihiro <kata1@jp.fujitsu.com>
> Signed-off-by: Allen Pais <allen.pais@oracle.com>
> ---

Hi Allen.
I already looked at the patch you sent the other day - the one that I
could apply.
Please include in this patch a description of what changed since the first version.

If there were no changes then do not resend.

	Sam
