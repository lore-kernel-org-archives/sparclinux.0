From: David Miller <davem@davemloft.net>
Date: Tue, 23 Feb 2016 23:05:31 +0000
Subject: Re: Invalid sk_policy[] access
Message-Id: <20160223.180531.2065639746334843320.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20160223202901.GC4941@oracle.com>
	<alpine.LRH.2.20.1602232250000.30129@math.ut.ee>
	<20160223205329.GD4941@oracle.com>
In-Reply-To: <20160223205329.GD4941@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sowmini.varadhan@oracle.com
Cc: mroos@linux.ee, sparclinux@vger.kernel.org, edumazet@google.com, netdev@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 23 Feb 2016 15:53:29 -0500

> On (02/23/16 22:51), mroos@linux.ee wrote:
>> Since there are no config-dependent difference in the struct, maybe it's 
>> a compiler version difference for padding/optimization instead?
> 
> possibly. The v440 is using  a Debian 4.6.3-14 gcc, while the
> T5 is using "4.4.7 20120313 (Red Hat 4.4.7-4)"
> 
> But my question from the email remains. Unless I am missing
> something subtle in the code, a  struct request_sock and a 
> struct sock only have the sock_common part in common. So casting
> a request_sock as a struct sock may have issues?

Of course it can have issues and contextually we have to be careful
about what the code can assume about that casted 'sk' object.

Your report looks legit and I was hoping Eric would chime in here with
an analysis.

Eric, we can't access sk->sk_policy[] on a request sock.  I guess we'll
have to use the sk->sk_policy[] of the parent?
