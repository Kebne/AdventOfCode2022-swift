@testable import AdventOfCode2022
import XCTest

final class ThreeTests: XCTestCase {
    let sut = Three()

    func testFirstExample() throws {
        let sum = sut.sumOfPriorities(in: testInput)
        XCTAssertEqual(sum, 157)
    }

    func testFirst() throws {
        let sum = sut.sumOfPriorities(in: input)
        XCTAssertEqual(sum, 7785)
    }

    func testSecondExample() throws {
        let sum = sut.sumOfStickers(in: testInput)
        XCTAssertEqual(sum, 70)
    }

    func testSecond() throws {
        let sum = sut.sumOfStickers(in: input)
        XCTAssertEqual(sum, 2633)
    }
}

extension ThreeTests {
    var testInput: String {
        """
        vJrwpWtwJgWrhcsFMMfFFhFp
        jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
        PmmdzqPrVvPwwTWBwg
        wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
        ttgJtRGJQctTZtZT
        CrZsJsPPZsGzwwsLwLmpwMDw
        """
    }

    var input: String {
        """
        vGFhvGvvSdfwqhqvmCPnlFPnCNPcCFcWcr
        ZbWZDMgsTHsrNNLJcJnsJl
        HbBWQgZVZZBzbgZphwjqpmmVfdGmjG
        vvCJLGnthChvtrvCCnRbTRqRPRBtbTRfPRRl
        djZSgHNNwjqcdWlbcbfc
        pFgMSfpMfzMDZFSgSjGJQQnCvMCVLnnJQLGC
        gVhQWQpcWZVwwHVvFvnnnnDFdL
        lzbPlztjltztzSjfGcPdTHLTHFCnnHCLndFGGd
        jsNbzbczclttSlfbqlljRQMJRMMpJwRZhspZgJRM
        hLJvfGcNDttSGvJtvSSJcqbqFBBWbjQqDrqbjDDjjb
        lTswlzZdssgFpdPwZpMQnCjngCCjWBQBWWQqng
        PRZMpzPZTdVZTfJvFvLFRctJcf
        JHbQtHVHHLLbTJmmZddgdgwhllMNhhhTgg
        spqpNGDjDPMhCFChMj
        DBSDDGnpSDsDWqWczcvSqWvsBtJJLLZrRVZLJRbBZNVrBHrV
        GwGhfhPhpHccvwSwrTsmsCjDmqTfbDqjss
        tQntQcNRJMFnnVQFFctJqCsRmsTjjbDqDlTqTbWT
        NZdVBZZNFzMFNNNvGprZcLGPGrrpcP
        SvCPLrrlCSvZLrCPPBNPRvNLQBbpmbdggQTTfpfQgpgTqbbb
        HVjHwMVwWtdMGwtwMwdhDFgbJgJqTmFMfFfmmfTTpq
        whtHVcjDtHWtsWdwVGVHthDPzRrNSsCRLrLRlZNzZSNzNR
        rjrlCCBtbtntwPPt
        FvfJHqBJQWWgWgWLwnMwMLbzvhwTTp
        WqHgWqBFgGfQgHfVdQFfVfrDllSsRSDmVmRCZZmSSSSZ
        gjnppCgGHNPrqqmFnnbr
        tGltVlJRtLRlrqcJcqZDqBJc
        VvhLlvWltWdVltRTLTfgwSjGNHhggQNQNjps
        HDWjCNfQjmwgWhcwPPVbZGcpMb
        sFltFBRRSRJBSSsBlSSnRLPZbVGMVPZpMpPZpcMrFZMc
        BLTBsstlqBRRBSvJJBsHdgdDNHCQHvbdCjQNNW
        lRGzWLZNFwJVbVVGcJ
        HqqpjPvHQnJgVgTnbdTV
        rVvjBQHQrQhCrzlzWrRlDZ
        jZjTZRSjZnhGZhzGnG
        HbnPHrCbBDMnhcrVLWWLLWWg
        MBwbCNDDptwNMttjdSnsqSRSFFdjtj
        bSfvcsNsDdccHHQm
        ljrlplvBhDHDHHHHJl
        jgpzhrzRrvhFRFrzFnWfZtTwSWZPbbqNbsTqsW
        vvCTvcDzHcgtvWjvcDcvgBCgwTdPFPpwpwmTSwwmdPwZpfZh
        rNLMNVqLGNrVsRNJNsPnGnnfnpSFGdfddndd
        VPQsMbVsPbzzvgCzgv
        wPsrqprHQQZsChZn
        cjgFLwWDlDltfLmTCnmWCnZZChCQ
        FccccSLGFwjVlfVLLtgdSPSpMpBMdMBRRdHdBp
        mQQcpmCCprrfLQqZVGqLGv
        PtsJdsMtTTTvFqLTnnqbGZ
        HjldthsHWztJzstZhBcHDDgpNpCpmrpgSD
        lCmhDljDJgWggcnh
        LdQrbdTDQGfGLPdqqFrHwRJcWRHgHBWHBJ
        sLqsGtDqdGQfSTsqtfqqVMzjCzlvllZljNpCsMMl
        CfLCZCCqqHlhSSrrtpRjpL
        mWQbnQZVTWwNdwmDSbpbrFptjDrjRj
        PJWVnTWPVnnclqqBsCCZHP
        tqvtbNCgqJSgZgZvSncrrcGjBGhcnVcR
        DswGQQQdRcjBnRDn
        sMdlFMQQpfZbvlNtZGgN
        RMlPllHtrlrlcZLsZfLcfwdDGD
        QppnQhTBgwQDJsGzLQ
        gTjnmjvphDSNMbtMbtMRHNVr
        RHHcChrVVChCWQmRnMZmnmbTbGmFnqTT
        gpzpfpszDwvDDNdwjdstnSMMHGMqvZnFTTZqbq
        DsDdpfppwHsgJdjzfdDjdssLPlRccPQQrJcchPQWWQRhlQcr
        rsrjQjnRnQZZqMmMMVqs
        WTSTdvJLvTGJTGCMGvzBBpVVqqFVzBzVmf
        tTSJhGLJbJhLJRRbHPQbnHHMrl
        GGgMgBJHWHhLWMhWhgfrhgWLzmsmlzTtzHmsmlszRtszRVlT
        bvScppfcQfcQSFCQpnPqwwTdRTvmzVssvswtddsv
        ZDpqnPbQbPPnQbFbfSPSqbQJhGrjgMZBhWLrLrBBBBJWhg
        hQCCGCNhDmGFJsTt
        fcggBBpvBSrtsRTpRmpD
        wflWlBlfnvfWWgMNPPLhPnzhPmLQ
        pcGGTvVpcQLLzSPPPpVBVQwngNqgsJqgJgqSngsJMqJg
        RZDFGhtCDGmWfWsNdwJhnMgwswqJ
        ZCGjRGjZllFGHvvcTPjPTQpB
        FDVsWrFZnnnfNRJdgBBBMLsJLH
        wcThcTphvCThwTlblpzwGlpLRgHJWLgHLBHdHWJLBLWR
        mwcbPmClwlzlwvvbTmWbQSjZmZSrDnSNVZfVFnZf
        tMlttlFRSrcSFcwQSRwSzrMMPPGGPGLWgNfTNTcLPNPGBPPG
        pbZVCDTqnCjVDHnHVnhBPBBbhBhbhgLgmWLh
        qZCJZJqqjjCVvvRQltlzTrJtMMMw
        QvvdBDdMbdFFJrMMjjmjCfCntC
        lHTPsNLPcfVZLnfj
        GgsWpHPpTPWpNsGvgdnDbQRQFRbdQg
        jPNwllsVZjhslSjwGShZMdJDmmdmWLtMDDPHMPFd
        QbvpDrbBrtMbbHJmcH
        vznvzBRpBprQBqQZjNswwZDnSlGjZl
        PdNTzLQPLrVMzGcMtt
        FsSvDrvmrwDggHGwgV
        vlpZpZmfnmFTlTWJWdbrdh
        mZmnggMTSJrrmnrbmTbngJMtwPvwzzRvPGhQdGZPGPLvGvRd
        FFVBNHVlFlDfCsWwLwPzzhGPCvzhQv
        qBHLsDcfqFfDDfsFLNcNNBFsrgpMpnJSbnmTnrtmbMSqnpnr
        qjBNwBPNPspqddssbsTsMDhTDrThQb
        gvzZSZzFbgHnrHmn
        fcvfZcRSZFGfZcvFbGttcPfpVjWVwqBqdwNdwNNpqV
        RrTmtTrqznrnRCSqJrWlWDbhWVnfVDVWdclV
        QBBgHQGvHHQswLHQQLGLHdLhfhlZZFlsscVDZfWfDhVlZZ
        dLBMPpGPjLHPHPBHjjgQjHQztSJRztmrNCSCmSpmprrrrz
        HHWJgjjsJrPBWBjgWgDvbbvtbNDNVtttMPPp
        SnLTlhhNSntRVVLFVbbb
        ChqdcNTNqqJCrQrQrrBC
        BvfLLngFLDrrlDFDDnGmGlmzqzdGqMMWWwWW
        RVsPbsbVZbjctccCcsCSPmdNqMqMWddwqVzhhNHwHd
        tcsjPZRctZTSbbtSbtsSjZznnJfJBrfJgLvJJDDBvpTrgp
        LJJsNdtJQtbWRJQttjGhjVnjcnzcsczGqj
        MDPPlvCwrTlZfMMvTlPTdVcVhVVjchSBrjccSnnq
        lgZCvTTZfMgHLptdRgmR
        gCDrJRNgJDZRCwMgqGbtVVjTjlFbbTtR
        mccnfcnSQScdvdcQQQpWdnWSjPqTbFFlbPqbPVGNjTPjtN
        NnzmpWmBBzzpzDgwhDghrZrw
        wcbVDBQwVBFQLFQDQcqQcLcJfpHJjmljGgMHfcfgGgjf
        PtnWMtSnlgJmWWmm
        nThPtRnzntstvrtRPqDFLMLdDwBBFLQDBT
        zshqnVqTwqHqZQgZDSZjpFjFFF
        PsBRvttdcgFFBSmc
        GlPsbLtrvrrrtJlCTnVTlwwfnhwVqH
        CvVVnFwWZnZwJZMNlCMNMpbMrrQG
        cpghqzqqtzbGMjTNclGN
        PqLBsgqBsSfBffShVmvRVwWsFpwZVpsn
        LzsLSScvscqNdGdgddQjCDbzhpCDbRbhDpDDwDwt
        ZlMBBBnlMFVFHVMJflJjJBfhRnCbCDpRttRPDCbWpCRbpW
        mlrFmJrmscNGmsjm
        FqQjLRjfvTFvlPHHNPMBDDNDPR
        chWptpcWTzBPMsMMMBHW
        zcJghwJZpZcgnctccdzzpGQrbQbblFFlTCCFTbdCFCFq
        QcwNpCcQzpwtCGPPPnrGrfHfvN
        FgjhhhjMVFVjqRRqDBVBqvMZvdrHnPZWZvsnZHdWnv
        ShBFhDVghhTBgBBFRRgRCmCPCcpPbwCmLTcCmbpb
        ZzlzsBzZnWnsBhFRvfvvLfWqfvMv
        GgQGjjddHHPwpHpTGjPdHMvtvwJqLtJRFlRFRqMwLc
        dgbbdjpGGgTHGGgQgdpmpgblrBrhrhCBSSznChsVhBsmNB
        PhSwPdnpsmSWWcjjDFNqnc
        GJGCTLbTZTrlfflVLFchHDHHDFcVVN
        RhlhrllQZhCsPvRBvMtSvw
        GVgnrgTWGVGjLVjWSpvvNmPTmpQmzvhf
        tBbBDsFtszzSSbPZbh
        BqlqdcqSJtFMdMjWrnGCWRrWGG
        sJVJsQhMhPPSQMwdHRmmsmmwRmsr
        zLFjLDTBFNWWwrqrffldlRdFRq
        BLjzjTpzLpzWGTbQpMJvVMQwQhhMQM
        RqSztDRhJDLmRMLlfvsP
        dMdMMHZCsnbdvmbP
        VHcZVVcZTwTQpgHQcgFMFBpDDzBqqqDhqJSjSjJjSD
        rdMnMGjdHhfnjqWWDJPpGWPtvW
        PTBSQSSzZSBSCzQFFSlZTFSvcZpWWcJvtJppvZpLLcDVcv
        sgQCsBmmlFCPFFzTgTBgdNnrNndnMrrrfbrNjf
        bpZdggTjHbgLglpHjldvHpjdhTVzmhzzzFPzmhFsFQSFnhhN
        rPCDBcCCMPGcWDNNWQzQQSNQnNzQ
        fCCJtDtGGGfGBtGqBrrcfRBcvPwpLgdZZvHdljvqpvdwbpvl
        qpmsNldnlHlCqQlHsHNHwJpJMtwvvvjMvfWjpDtt
        TccVBScrzBzzTGPbVTPQhWjfMjwwRtJtjMtWDWWfDS
        FQFbzBGczGBFLnFmmqsCLg
        qpblblvpvJzStJDrhrnGrdhDfFqf
        ggNQNwBgmTcgCBTBTQQjNfDCnZRRRrRGCnrFfdnhrC
        mjVFHQTHNjTwcmpzJzHltltbSssS
        WChWmdcmzndhFcZrrbvrVMVssj
        NQLDlDplpSJGpLfRRMZVBBGjVsGbbjbBZsGv
        QNDfNqlpLgSfNfNgNfpgpqwndwWwnCCnnTFMdHndzn
        ZGRPTngTZMSGMGnhSgRjQHsPbqjmsWHQCQWbNN
        BFLLfpzVDBfDdlfQcsbVcNmQsqqbcC
        zFvdplLDLtzFmrrwMMtTrShZ
        nTdmnVCGqTsSBTqv
        HlMPwMlHfPSfBBmFBfSL
        trHHwRHRwMHPMJQJHnDhbdRhdpCZmChNnd
        lwHWjzplvHqWHGsMLsLwLfgdfLdg
        tPJNPQmQmSGcTtFmctGmSCBgsBBRbLBRVdLVLCBBLgVf
        FPtTPQNPrPPQctTcNPSQJJPDjlzplnGDDjWWplWHhGvpnr
        jwvvDbvsRsrrjrfvfrrZsPpCpmPJJPqlqWmzRJRTqq
        HdLttdSQHdLHMMtNdLMSTtHpCmPplWhCzmzmPWlJhlNplP
        BTSLtLLQtnVZDnffbwfw
        snvQdrtrQprWpgmGLp
        FhzwlwHccBcljFBSDmHmLpgRmPDCffWL
        zFhllqjczzwJqqSqlZMsvJgVNMTbssVNnQbb
        dLZHrWjWPFZWZnPjZttjddFnMDVMGJMQqvMVGVRVpjVpGVvv
        zhzTwTlfTwCsShSgNhfzsQQqvMQStQMDGJJGvGQVvq
        TTwCBfsfBwhzwTBCzlmHZdLmBBbtLnLbFnnF
        BhBRLFmlBlmhgShHmhSlZlFgvbQNwvcsvMCcsQCwNQvNMsBw
        ttWddDjrfjDcssscDbvH
        jfjfPWdzdfjdnWpjtrzqnhmJGJFhSJRHSmSmlqlHmq
        QvJTgvsvghHRHHNbZvNZTRSzBBCLrDqzrfDDtJSqSLBC
        cPPwdcFFPDwfFrBrFfFfrC
        nppwdplpRvllsgDH
        BGLLWLLwHVZwHnNhwsMsrqMqhh
        STlTpDpmjzmjjjgccqdsbNbBhlNnNMhsqs
        pjmgjfSDSzmSgFzRZQfRRZLBVLVtZZ
        WHjddztMtVLNNFFTmbFPFPRw
        bJnvpQfqccQJZfpcbvCphcFGDPFGRwDGDDGwGsmPFnPF
        rvffQJZJqrpZCJZJQrQpvBvStlSWSzVSWBbzBLzjtjWWWj
        SJFMSMGSDLTsFgHvHL
        mNzRrRRzjzqqgPHvLTHjlvWg
        ZLbRpRnRnCrbmnmrRRNnwbGfMwDwfDDdSVMdVJdd
        nsqTbhcDssPsPWsnchPJMSTSMmJMwTSTCJJfJw
        DHvFvvdHpvpGFHDMVVJVplCCVpggCl
        RdQjtvHtDQNGsZqzcqPqbNcq
        GFzRjczzQJnLjJvvTj
        mSfHrNHDzHDrDSSSBvTZLTNqWJWBWLlv
        PfgCmfPzDVrtHsddVMsRFcVFQM
        sfBgfBfBsHBHFGhsqfjgQZtQQMdZgbZQptbM
        rNLRSzRTrrvvLSTWGpjpNZdQPtGtMdNM
        wvSWLwzTGTCcwwwJwvwcrcRcVfFBqhhVhDqhBllBfFqBCDCs
        LbTpDTcMTSzzMLhScnDnSppNQwVNZFBVnFsrwQQZrQrQrN
        tJtJCRlGWljGWCtjJZVPsJBsVwQmrQNN
        fvHRftqjGfWGwtfGqvLTzDTzzzchSbMDTd
        JJhWZlhqLDHtBDrqrB
        bwwmfrSmbmFjVSFQwSdpDvGdpPnRvDtHpGtGPG
        VgFfcSQfFgmLLrNThllTZc
        QmfvrpnvrrJGnBSCFTBMSWFS
        NVMggbVPzCTgDFDD
        NRqHRZjVRZdRVdZwNPrMrchGhGpcGfvhQlHJ
        nlBdCldndlZTttSSBBccPfGWLLHcTTcWPbbW
        jpsFzFmzDzNzDGChGcGGmPQHQf
        CNzqvvVJNFqvgRtlqRtdnwSZ
        MJtDbNHDDpmVPJVzzjLm
        RslhvlfRTWvWWRwfllSZngmggznjSPznLjmSnz
        TlhffRwWQhChDqbBQLFHqNrb
        HWnmSbzflWltlzLfWWDzjMBvCjjCTCgcMvzBBB
        qRRRZJwhZFGdRNfghVjMVVgfcghC
        QFFqwNNNwdNZZpqqZfnDSHmmlDLtWtHWlQmD
        JrFdNTTLRBTJrFVrBNdVLFBdlHbzQQsQzbPJtpbtltWsHbQw
        gZffDfMlCfjCSqMcpHPWHszstzHjQwpb
        GMnvfGlfvSqvcMMDgDDcfnqSVFRdmTmVdNBTdmRmBFVnLLBT
        ZvRHtDcZntLZssMssQBrMdnC
        jglqlVdlbqgVWjJMbrrBCpmQBBfrpm
        GqVVPPjPNjFVllNjJjFDvzTLZRvcLRLvTGdGDv
        fDVzvVfzzZPMsMbb
        LHtBwLBdhFgdHLLthRwFGGMsmrHMmmbZSmqbMGGG
        bblRwbTRlllfVQnCQn
        fVZzjRzpzpVCRPZhVWQvvLsWWWFQlmjWmG
        JDHgJdtwbZqJqsWBBDLlQlvLms
        cHHtdbqwrqbbtSbTgSTcVCMRZnRRVNhVPNMPpfMc
        fCMPBBdpMpsqMssQccnV
        TlwGWDjDZHLjZHHlLGmnlnNcRllsJcqtsJRV
        ZHhZHThLLrGwjDDjLwGWWWSjPpbpzrvBFBFdBBbqvCbpFfpg
        bvDfDPtCVfFFVdWWpmLRmzWzzdBW
        jgZTghhjrGrsswrsghHrlgTGzSRmMLwpJMSMzWLLWRzpRRSc
        lpjTpGHlpsNGTHllHrCFnDNPtVnvfQtQtQNP
        BwlQcwZBwwwQNqJTrrsRGCDTNt
        bMpVPSfRvCbCtTqsCs
        dPSRfRpPPjjmLMgZBZBLZZwFQnZn
        TsVfggTqVnsLVTdTpmDdRhwPRtPRDRwD
        ljHBSWZvvFWvBFPppnQPwnpmzR
        MSHSjbBclBSjccLJgqgnLVqTbsTT
        zncfVgRzVJgnTfVqNHvZJZNJNMpHbdvH
        PCBpsLjPPmMGdHNdHBHZ
        jSLlrhLPDWLrPrDCLPCfnpzcVRFcRTnlVncntT
        ccvSgjHtRjcjSvjvSrBjzSHHwnJPbgwPPZVVVZnPpZlpwnlT
        ffqNqGGsGWqLTNqZwdndPnnJJpZVJW
        sNmqhsCMQsMTmjrcmrHrRj
        gWWWzNVJDwDzVWVDGbGNnhTnHLsmhmhfsQTNSmHd
        vtMPZvrZvqtqBHljrqSnnmTfLfdnQsjhjmhL
        MMPZPBqZCrBtvZcrBlDbGbbbzHJCbbRwgwDz
        hGSRhsMswhcNNGwhwncMnCqCJNrHJPJJrJtCJdqHJm
        BgVTzWBdTfCmfCJH
        dlbVFvvWVZhSRQDMnlhc
        WfpzBZmgJlQVGvWF
        wHSbrHwmccnrmrHsClGqFGbQjQjjQJQQGv
        SHPwwsRcrrNtrNSsphmZLzpfzhghZPdD
        DFDPRpmgbPQtmgBBQDDNJTMMBZsqsZGqGZTGCGSqWG
        fVvVVLcJVzlvzhqfSTCsZsMGMHqq
        zJdrrdnzcLlwczwbQmQngRDQPbtDpQ
        HDZZrpFqwRrQfBqhjjlVlQ
        czTgvvWPNgPGcTlsQflCVshClC
        PgNvtSJNvGVMMzNzgGvPGGLHFDdFdmZSZRdDdRrmpFwL
        SVHNVFVPBHJqHhgFCgzLmCwppm
        DvDdsGZljDlfdZnjnnZGMzLpRgLfMCLmzfPLhmgp
        jZDZlrvrZTrTrTQrDsjslHNJqtWbWHbqbPBWNVQWBJ
        NmGGBdWWJDJTTZHm
        hFVhcqFjncpcppSjqfppqDvzDDDbbDZvDZZbHfJgvJ
        jrPqnnHnqSPwPGWPdWst
        BfhbwMwbbPbHPPPlrdJjrlMJLrJVTd
        pnQnGnWDjnJdlJCh
        qshsWvpttzNNQDtzRRPvwfcPHBBBHwbw
        SHzGRQjhwwhGzjjwRjfBqpqbNCqNnnqqQqPlQC
        TZtgLmZgVmgdFgmZtdrbNqnqlNlpblnlrnBd
        DvgmvvZgmWJJjwHHhJSzps
        JjlrlJjPJgDjJjJnDRDjNwGGqMvSddvPvwQddqSVvq
        SLpphFLhFZhWLzvswwWqsqVVQWdv
        FSHtTLZpfzRDDrJgRNjT
        wjCMvrMlqqWHvWqddrHqgnBNhcffthhVLtpgLBnw
        GbQFZzZZphnpgNZV
        FhFzRTDRPzsRQGQGTFlllrJHjdsJlHMqjjHr
        LqDcTbmJcqSJSTmnrTcmJrfffplfjZsGZfGGZfQLdplj
        hWddgBvzWFZfPsQlGh
        RBWBRCdHtgHttVVzHBVNNNDwSTDcSSSbScDDwbwbnmRS
        FFPzwlZVVrzFFlFLVlllZdHCHPQMnJQQbhhChdhCbb
        BRRqGBgRfqvgvBDDDTRgghNCMMTQNNbVJMNJJdbbdT
        DfpgjGfsRWrFVzwLcs
        PMTSdSmFjhFpNTqvppvRBrRBrDqB
        HnZZznJbzGZGlZtZWHlJGcGcwMvQBsrwRDQvcDgrgDgrqRvq
        HGlGfnJZfMMCfNhm
        nRssqlqVRppVwdMMQwFgtRFz
        smTvLLTvvNLtwMMQNg
        CmPGBvZGWvBSGGDmTZjZlhpJcpHDJsbDnlrrprpl
        djcQGNQqdGdGqMCgndwgCLDMgW
        nvBvHpBppnvPPnJTBWLJVMwVfWJfCbfWgW
        hsHHpBsvRTHpsPszTBTTsRTslGqGqlcqlScnqmhZmmZSZSjl
        DddBHCmfWCBTDBHTHfMpzhzpJJMJsFrGrz
        tPVPmbnttjPnZvSvSbnmZPZPNpNGMpJNzzNrGJpvhsshMpFs
        mwnZcbmmStbVtVjbZVlcLTBlcLCRHRDWCWWW
        """
    }
}
