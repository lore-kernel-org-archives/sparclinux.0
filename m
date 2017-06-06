From: David Miller <davem@davemloft.net>
Date: Tue, 06 Jun 2017 19:05:55 +0000
Subject: Re: [sparc64] crc32c misbehave
Message-Id: <20170606.150555.855421580901340490.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <ccdf645b-e22f-ef71-53df-993cc45869c0@sandeen.net>
        <260a016f-0f17-e286-ceca-83b6977f2fc0@sandeen.net>
        <20170531.124916.1406665885250072302.davem@davemloft.net>
In-Reply-To: <20170531.124916.1406665885250072302.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sandeen@sandeen.net
Cc: matorola@gmail.com, sparclinux@vger.kernel.org, linux-xfs@vger.kernel.org


Just FYI, I've meanwhile pushed a fix for the GCC bug that created
this mess to all active branches.
