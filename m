From: "Eric Brower" <ebrower@gmail.com>
Date: Fri, 17 Mar 2006 19:10:13 +0000
Subject: Re: bbc, envctrl and sun blade 2000
Message-Id: <ec7cefb0603171110p28b09f1dm4cb6cdaf5e001012@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <87k6auqm68.fsf@thorr.asgardr.info>
In-Reply-To: <87k6auqm68.fsf@thorr.asgardr.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 3/17/06, Daniel 'NebuchadnezzaR' Dehennin <sparc@asgardr.info> wrote:
[ ... ]
> The module envctrl do not load: "no such device".

The envctrl module is not suitable for your SB2000 system-- the
version currently in 2.6.x supports only the
CP1400/CP1500/Netra-T1/105 plaform.  I -think- you want bbc only.

--
E
