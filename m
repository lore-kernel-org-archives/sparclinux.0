From: "David S. Miller" <davem@redhat.com>
Date: Wed, 14 Apr 2004 20:22:18 +0000
Subject: Re: Compile problem with sparc64
Message-Id: <20040414132218.56106471.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1081973754.3372.5.camel@pegasus>
In-Reply-To: <1081973754.3372.5.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org


We know, see other postings from today.

Just comment out the "-Werror" line in arch/sparc64/kernel/Makefile
for a quick fix.
