From: Bob Picco <bpicco@meloft.net>
Date: Sun, 22 Sep 2013 17:16:09 +0000
Subject: Re: [PATCH 5/6] sparc64: Fix inconsistent max-physical-address defines.
Message-Id: <20130922171609.GI29427@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20130921.011630.1418111133842440021.davem@davemloft.net>
In-Reply-To: <20130921.011630.1418111133842440021.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Sat Sep 21 2013, 01:16:30AM EDT]
> 
> Some parts of the code use '41' others use '42', make them
> all use the same value.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>

Acked-by: Bob Picco <bob.picco@oracle.com>
