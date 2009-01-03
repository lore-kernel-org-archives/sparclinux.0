From: David Miller <davem@davemloft.net>
Date: Sat, 03 Jan 2009 20:56:20 +0000
Subject: Re: Can we rely solely on __arch64__
Message-Id: <20090103.125620.95315805.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090103122645.GA18259@uranus.ravnborg.org>
In-Reply-To: <20090103122645.GA18259@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 3 Jan 2009 13:26:46 +0100

> So how about simplifying the checks to read:
> 
> #ifdef __arch64__

This seems like a fine thing to do in sparc specific headers.
