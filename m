From: David Miller <davem@davemloft.net>
Date: Sun, 02 Mar 2014 19:45:50 +0000
Subject: Re: Ptrace implementation
Message-Id: <20140302.144550.1825140784401922589.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <D37E7164-2F27-4758-AF5A-72173FA4C969@erikkooistra.nl>
In-Reply-To: <D37E7164-2F27-4758-AF5A-72173FA4C969@erikkooistra.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Erik Kooistra <me@erikkooistra.nl>
Date: Sun, 2 Mar 2014 15:48:09 +0100

> but from my tests it seems it is stored in G0.

%g0 is the "zero register, writes to it are ignored and all reads give
zero.
