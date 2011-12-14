From: David Miller <davem@davemloft.net>
Date: Wed, 14 Dec 2011 17:54:43 +0000
Subject: Re: Sparc-32 doesn't work in 3.1.
Message-Id: <20111214.125443.973289484729064945.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111211111801.5942ab39@sf.home>
	<4EE80891.70604@landley.net>
	<20111214204225.7c8ec86c@sf.home>
In-Reply-To: <20111214204225.7c8ec86c@sf.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: slyich@gmail.com
Cc: rob@landley.net, aboriginal@lists.landley.net, linux-kernel@vger.kernel.org, tytso@mit.edu, sparclinux@vger.kernel.org, jakub@redhat.com

From: Sergei Trofimovich <slyich@gmail.com>
Date: Wed, 14 Dec 2011 20:42:25 +0300

> It forces compiler to geterate "usual" pattern for relocation.

No, this is wrong.

The right fix is to simply teach btfixup to be able to patch
the 'restore' just as equally as it would patch an 'or'.
