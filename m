From: "C.Newport" <crn@netunix.com>
Date: Fri, 20 Aug 2004 22:00:16 +0000
Subject: Re: Buglet making vmlinux with -j
Message-Id: <200408202300.16219.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200408202156.06459.crn@netunix.com>
In-Reply-To: <200408202156.06459.crn@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Friday 20 August 2004 10:13 pm, William Lee Irwin III wrote:

> Hmm. Now that I've seen the patch I know what people are on about,
> but maybe I'm too dense today to figure out what "silently finishes
> before linking" means, as I've yet to decipher it even afterward.

Mea culpa - it means that I forgot to save a logfile.
make vmlinux -j6 completes all of the compilation steps but ends 
without complaint before starting the final linkages.

