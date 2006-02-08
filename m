From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 20:56:45 +0000
Subject: Re: div, udiv, mul, umul, rem, urem broken again?!?
Message-Id: <20060208205645.GJ27946@ftp.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1128550254.2140.103.camel@localhost.localdomain>
In-Reply-To: <1128550254.2140.103.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

FWIW, I'd do
	if (!strcmp(str, ".mul") || ..........) {
		str[0] = '_';
		str[1] = toupper(str[1]);
	}
instead...
