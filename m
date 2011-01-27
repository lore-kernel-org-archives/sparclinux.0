From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 27 Jan 2011 17:40:02 +0000
Subject: Re: [PATCH v2] SPARC/LEON: power down instruction different of
Message-Id: <20110127174002.GA4500@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1296127618-10894-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1296127618-10894-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jan 27, 2011 at 12:26:58PM +0100, Daniel Hellstrom wrote:
> The way a LEON is powered down is implemented differently depending
> on CHIP type. The AMBA Plug&Play system ID tells revision of GRLIB
> and CHIP.
> 
> This is for example needed by the GR-LEON4-ITX board and the UT699.
> 
> Previously the power down support for LEON was limited to SMP, now
> both SMP and UP systems use the instruction.
> 
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>

