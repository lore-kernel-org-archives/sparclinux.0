From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 20 Mar 2013 20:14:47 +0000
Subject: Re: [PATCH v2 1/1]sparc64: Do not change num_physpages during initmem freeing
Message-Id: <20130320201447.GA26322@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <757251363741928@web15e.yandex.ru>
In-Reply-To: <757251363741928@web15e.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Mar 20, 2013 at 02:42:07PM -0400, David Miller wrote:
> From: Kirill Tkhai <tkhai@yandex.ru>
> Date: Wed, 20 Mar 2013 05:12:08 +0400
> 
> > Common hibernation code looks at num_physpages during suspend and restore.
> > Restore is able to be called from initcall, which is before initmem freeing.
> > This case leads to restore fail.
> > 
> > Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
> 
> Applied.

Btw. I expect this patch to introduce some trivial conflict with a patch
in Andrew's queue which cleans up some memory management stuff.

This: "mm/SPARC: use common help functions to free reserved pages"

Just so we are prepared when it happens.
Stephen will tell us...

	Sam
