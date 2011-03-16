From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 16 Mar 2011 18:09:51 +0000
Subject: Re: [PATCH 1/2] sparc32,leon: APBUART driver must use archdata to
Message-Id: <20110316180951.GA9139@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1300282434-17917-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1300282434-17917-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Mar 16, 2011 at 02:33:53PM +0100, Daniel Hellstrom wrote:
> See Commit id 1636f8ac2b08410df4766449f7c86b912443cd99, this
> patch is similar to 19e4875fb21a69fbf620e84769a74d189c69c58d.
> 
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>

Patch looks good.
For commit reference always include the title of the patch:
"of/sparc: fix build regression from of_device changes"

Please fix up and add:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
