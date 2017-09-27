From: David Miller <davem@davemloft.net>
Date: Wed, 27 Sep 2017 22:10:20 +0000
Subject: Re: [PATCH v2 2/2] sparc64: Use lzcnt instruction for fls and __fls
Message-Id: <20170927.151020.2182569060914905496.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1506540326-9604-3-git-send-email-vijay.ac.kumar@oracle.com>
        <20170927195637.GB15193@ravnborg.org>
        <9DB110D2-67D6-4CAA-8C14-C3AF995D9711@oracle.com>
In-Reply-To: <9DB110D2-67D6-4CAA-8C14-C3AF995D9711@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: anthony.yznaga@oracle.com
Cc: sam@ravnborg.org, vijay.ac.kumar@oracle.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, babu.moger@oracle.com, rob.gardner@oracle.com

RnJvbTogQW50aG9ueSBZem5hZ2EgPGFudGhvbnkueXpuYWdhQG9yYWNsZS5jb20+DQpEYXRlOiBX
ZWQsIDI3IFNlcCAyMDE3IDE0OjQ1OjM0IC0wNzAwDQoNCj4gVmlqYXksDQo+IE9sZGVyIGFzc2Vt
YmxlcnMgbWF5IG5vdCBzdXBwb3J0IHRoaXMgZmxhZyBzbyB5b3WibGwgbmVlZCB0bw0KPiBoYXJk
Y29kZSB0aGUgbHpjbnQgaW5zdHJ1Y3Rpb25zIHVzaW5nIC53b3JkIGRpcmVjdGl2ZXMuDQoNClJp
Z2h0LCBvbGRlciBiaW51dGlscyBkbyBub3Qgc3VwcG9ydCB0aGUgVDQgaW5zdHJ1Y3Rpb25zLg0K
DQpUaGlzIGlzIHdoeSB3ZSBoYXJkY29kZSB0aGUgb3Bjb2RlcyBmb3IgYWxsIG9mIHRoZSBjcnlw
dG8NCmluc3RydWN0aW9ucyB1c2VkIHVuZGVyIGFyY2gvc3BhcmM2NC9jcnlwdG8vLCBmb3IgZXhh
bXBsZS4NCg0K
