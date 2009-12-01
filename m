From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 01 Dec 2009 18:13:04 +0000
Subject: Re: [PATCH 1/4] Added Aeroflex Gaisler entry in manufacturer_info
Message-Id: <20091201181304.GA25617@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1259679176-29835-1-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1259679176-29835-1-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Kristoffer.

You need to fix up the $subject of all four patches.
Then should all contain a proper subsystem prefix.

    "sparc,leon: short title"

was used in the past.
It is good to be consistent here.

On Tue, Dec 01, 2009 at 03:52:53PM +0100, Kristoffer Glembo wrote:
> Here comes a series of small patches.

This does not belong to a changelog. This is to be added
in an intro mail.
The changelog should be readable as a changelog 3 years from now.


	Sam
