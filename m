From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sun, 27 Feb 2005 12:20:25 +0000
Subject: Re: DBRI fixes and improvements [2.4]
Message-Id: <20050227122025.GA1601@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <421FA83B.2050901@wp.pl>
In-Reply-To: <421FA83B.2050901@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Feb 26, 2005 at 02:01:02PM -0800, David S. Miller wrote:
> Feel free to do a 2.6.x sound layer port of this driver if you
> wish :-)  It's the only SBUS audio driver that no port attempt
> was done for.

For 2.6, there is a DBRI driver in ALSA 1.0.8.
It may need some improvements based in these fixes though. I remember
struggling with dbri_cmdsend() at the time.

-- 
Martin
