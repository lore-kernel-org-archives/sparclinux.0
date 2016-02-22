From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Mon, 22 Feb 2016 01:02:01 +0000
Subject: Re: Recent spontaneous reboots on multiple machines
Message-Id: <20160222010201.GB23053@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1601061716510.27880@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1601061716510.27880@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On (02/15/16 07:54), Meelis Roos wrote (on sparclinux):
> > > It's getting more strange. I ran 4.4-rc8-00005 for 2-3 weeks nonstop, 
> > > doing git clone and make -j4 in a loop, on both V240 and V440. Worked 
> > > 100% stable.
> > > 
> > > Then I git git pull from kernel.org, tried to compile 4.5-rc1 (or was it 
> > > rc2 already), on the same running 4.4.0-rc8-00005 and it rebooted, on 
> > > both V240 and V440.

Hmm. My experience was a little different than yours but maybe we
are seeing the same thing. 

I get a panic that matches the description in d188ba86dd07a ("xfrm:
add rcu protection to sk->sk_policy[]") but the panic remains
even after applying that patch, so maybe there is still some
race-window that was missed by the patch (or I'm missing some additional
patches?)

To reproduce the panic on my v440 (sparc sunfire) I fixed up my transparent
proxy env, and do a 'git pull' on the test machine (running 4.4.0-rc3+).
The reboot on panic was quite noisy on the (serial line to) console, though I
didnt find anything recorded in /var/log/*, and, with
kernel.panic = kernel.panic_on_oops = 1, the ssh session terminates quietly.

here's what I pulled out from the console noise:

[3816414.196028] Unable to handle kernel paging request at virtual address 77e0000000000000
[3816414.302455] tsk->{mm,active_mm}->context = 0000000000001f95
[3816414.378057] tsk->{mm,active_mm}->pgd = fff000123c040000
   :
[3816414.651546] git(7768): Oops [#1]
[3816414.696158] CPU: 0 PID: 7768 Comm: git Not tainted 4.4.0-rc3-roos-00790-g264a4ac-dirty #29
[3816414.807133] task: fff000123e2a31e0 ti: fff000123e3dc000 task.ti: fff000123e3dc000
[3816414.907887] TSTATE: 0000009911001601 TPC: 00000000007ed400 TNPC: 00000000007ed404 Y: 00000276    Not tainted
[3816415.039484] TPC: <xfrm_selector_match+0x20/0x3a0>
                      :
                      :

Looks like the pol is the bad vaddr. When I insert printks, I see
the following in xfrm_sk_policy_lookup() 

   dir XFRM_POLICY_OUT  sk fff000123e1aa000 pol 77e0000000000000

Relevant parts of the stack trace from console messages  are shown below.

 xfrm_sk_policy_lookup+0x30/0xc0
 xfrm_lookup+0x20/0x340
 nf_xfrm_me_harder+0x54/0x120 [nf_nat]
 nf_nat_ipv4_out+0xe0/0x140 [nf_nat_ipv4]
 nf_iterate+0x8c/0xc0
 nf_hook_slow+0x1c/0xe0
 ip_output+0xd4/0x100
 ip_local_out+0x30/0x60
 tcp_v4_send_synack+0x4c/0xa0
 tcp_conn_request+0x934/0x960
 tcp_rcv_state_process+0x1dc/0xee0
 tcp_v4_do_rcv+0x68/0x220
 tcp_v4_rcv+0xb04/0xbc0
 ip_local_deliver_finish+0x114/0x2a0
 ip_local_deliver+0x38/0xe0
 ip_rcv_finish+0x14c/0x380
 ip_rcv+0x26c/0x3e0
 __netif_receive_skb_core+0x7c4/0xb60
 process_backlog+0x70/0x120
 net_rx_action+0x204/0x300
 __do_softirq+0xc4/0x200
 do_softirq_own_stack+0x2c/0x4
  etc.

Unfortunately I cannot get a crash dump on sunfire, so no way to tell 
what other kernel threads could potentially be racing with this.

Still looking..

--Sowmini
