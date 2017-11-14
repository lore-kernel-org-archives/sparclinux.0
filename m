From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Tue, 14 Nov 2017 14:52:25 +0000
Subject: Re: linux-next: Tree for Nov 7
Message-Id: <1510671145.4344.1.camel@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171107162217.382cd754@canb.auug.org.au>
 <CACPK8Xfd4nqkf=Lk3n6+TNHAAi327r0dkUfGypZ3TpR0LqfS4Q@mail.gmail.com>
 <20171108142050.7w3yliulxjeco3b7@dhcp22.suse.cz>
 <20171110123054.5pnefm3mczsfv7bz@dhcp22.suse.cz>
 <CACPK8Xe5uUKEytkRiszdX511b_cYTD-z3X=ZsMcNJ-NOYnXfuQ@mail.gmail.com>
 <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz>
 <20171113094203.aofz2e7kueitk55y@dhcp22.suse.cz>
 <87lgjawgx1.fsf@concordia.ellerman.id.au>
 <20171113120057.555mvrs4fjq5tyng@dhcp22.suse.cz>
 <87h8txw87w.fsf@concordia.ellerman.id.au>
 <20171114090444.lhrkuywuls26g6lu@dhcp22.suse.cz>
In-Reply-To: <20171114090444.lhrkuywuls26g6lu@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, 2017-11-14 at 10:04 +0100, Michal Hocko wrote:
> If there is a general consensus that this is the preferred way to go,
> I
> will post the patch as an RFC to linux-api
> 
> [1] http://lkml.kernel.org/r/20171113160637.jhekbdyfpccme3be@dhcp22.s
> use.cz

I prefer the new flag. It is cleaner and avoids unintended breakage for
existing flag.

--
Khalid
