From: "David S. Miller" <davem@redhat.com>
Date: Mon, 05 Jan 2004 20:58:00 +0000
Subject: Re: [2.6.1-rc1] CONFIG_DRM_FFB=y Fix
Message-Id: <20040105125800.0adc0305.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040103133147.0182a1dc@snowdrop.home>
In-Reply-To: <20040103133147.0182a1dc@snowdrop.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 3 Jan 2004 13:31:47 +0000
Ciaran McCreesh <ciaranm@gentoo.org> wrote:

> 2.6.1-rc1 gives compile errors with CONFIG_DRM_FFB=y:
 ...
> I seem to remember this being fixed in 2.4.x recently, but 2.6.1-rc1 is
> still affected. The attached patch sorts it out.

Right, I forgot to fix it on the 2.6.x side when I did fix it on the 2.4.x side.

Patch applied, thank you.
