From: David Miller <davem@davemloft.net>
Date: Sun, 24 Aug 2014 19:06:29 +0000
Subject: Re: [PATCH v1 1/3] sparc64: correctly recognise M7 cpu type
Message-Id: <20140824.120629.90344151056886868.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1408686773-3044-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1408686773-3044-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Sun, 24 Aug 2014 08:35:06 -0400

> What BSS does this code touch or reference? None that I'm aware of.

You cannot control what code the compiler emits, it is therefore not
safe to call C code.

Please just drop this for now, thank you.
